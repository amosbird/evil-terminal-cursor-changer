;;; evil-terminal-cursor-changer.el --- Change cursor shape and color by evil state in terminal  -*- coding: utf-8; -*-
;; Package-Version: 20171008.1
;; Version: 0.1
;;
;; ## Introduce ##
;;
;; evil-terminal-cursor-changer is changing cursor shape and color by evil state for evil-mode.
;;
;; When running in terminal, It's especially helpful to recognize evil's state.
;;
;; ## Install ##
;;
;; 1. Config melpa: http://melpa.org/#/getting-started
;;
;; 2. M-x package-install RET evil-terminal-cursor-changer RET
;;
;; 3. Add code to your Emacs config file:（for example: ~/.emacs）：
;;
;;      (unless (display-graphic-p)
;;              (require 'evil-terminal-cursor-changer)
;;              (evil-terminal-cursor-changer-activate) ; or (etcc-on)
;;              )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(require 'evil)

(defun etcc--in-tmux? ()
  "Running in tmux."
  (getenv "TMUX"))

(defun etcc--make-tmux-seq (seq)
  "Make escape sequence SEQ for tumx."
  (let ((prefix "\ePtmux;\e")
        (suffix "\e\\"))
    (concat prefix seq suffix)))

(defun etcc--make-cursor-shape-seq (shape)
  "Make escape sequence SHAPE for XTerm."
  (if (listp shape) (setq shape (car shape)))
  (let ((cs (cond ((eq shape 'box) "2")
                  ((eq shape 'hbar) "4")
                  ((eq shape 'bar) "6")
                  (t nil))))
    (if cs
        (progn
          (setq seq (concat "\e[" cs " q"))
          (if (etcc--in-tmux?)
              (etcc--make-tmux-seq seq)
            seq))
      nil)))

(defun etcc--make-cursor-color-seq (color)
  "Make escape sequence COLOR for cursor color."
  (if color
      (progn
        (setq color (concat "\e]12;" color "\007"))
        (if (etcc--in-tmux?)
            (etcc--make-tmux-seq color)
          color))))

(defun etcc--apply-to-terminal (seq)
  "Send to escape sequence SEQ to terminal."
  (when (and seq (stringp seq))
    (send-string-to-terminal seq) ;; alacritty lost
    (send-string-to-terminal seq)))

(defadvice evil-set-cursor-color (after etcc--evil-set-cursor (color))
  "Advice `evil-set-cursor-color'."
  (unless window-system
    (etcc--apply-to-terminal (etcc--make-cursor-color-seq color))))

(etcc--apply-to-terminal (etcc--make-cursor-shape-seq 'bar))
(etcc--apply-to-terminal (etcc--make-cursor-shape-seq 'hbar))
(etcc--apply-to-terminal (etcc--make-cursor-shape-seq 'box))
(defadvice evil-set-cursor (after etcc--evil-set-cursor)
  "Advice `evil-set-cursor'."
  (unless window-system
    (etcc--apply-to-terminal (etcc--make-cursor-shape-seq cursor-type))))

;;;###autoload
(defun evil-terminal-cursor-changer-activate ()
  "Enable evil terminal cursor changer."
  (interactive)
  (ad-activate 'evil-set-cursor-color)
  (ad-activate 'evil-set-cursor))

;;;###autoload
(defalias 'etcc-on 'evil-terminal-cursor-changer-activate)

;;;###autoload
(defun evil-terminal-cursor-changer-deactivate ()
  "Disable evil terminal cursor changer."
  (interactive)
  (ad-deactivate 'evil-set-cursor-color)
  (ad-deactivate 'evil-set-cursor))

;;;###autoload
(defalias 'etcc-off 'evil-terminal-cursor-changer-deactivate)

(provide 'evil-terminal-cursor-changer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; evil-terminal-cursor-changer.el ends here
