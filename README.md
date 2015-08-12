# evil-terminal-cursor-changer - Change cursor shape by evil state in terminal

*Author:* 7696122<br>
*Version:* 0.0.2<br>
*URL:* [https://github.com/7696122/evil-terminal-cursor-changer](https://github.com/7696122/evil-terminal-cursor-changer)<br>

[![MELPA](http://melpa.org/packages/evil-terminal-cursor-changer-badge.svg)](http://melpa.org/#/evil-terminal-cursor-changer)

## Introduce ##

evil-terminal-cursor-changer is changing cursor type by evil state for evil-mode.
 
When running in terminal, It's especially helpful to recognize evil's state.

## Install ##
 
1. Config melpa: http://melpa.org/#/getting-started
 
2. M-x package-install RET evil-terminal-cursor-changer RET
 
3. Add code to your emacs config file:（for example: ~/.emacs）：
 
For Only terminal
 
     (unless (display-graphic-p)
             (require 'evil-terminal-cursor-changer))
 
For All
 
     (require 'evil-terminal-cursor-changer)
 
If want change cursor shape type, add below line. This is evil's setting.

         (setq evil-visual-state-cursor 'box) ; █
         (setq evil-insert-state-cursor 'bar) ; ⎸
         (setq evil-emacs-state-cursor 'hbar) ; _

Now, works in Gnome Terminal(Gnome Desktop), iTerm(Mac OS X), Konsole(KDE Desktop).

## Change Log

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License as
published by the Free Software Foundation; either version 3, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; see the file COPYING.  If not, write to
the Free Software Foundation, Inc., 51 Franklin Street, Fifth
Floor, Boston, MA 02110-1301, USA.

Code:


---
Converted from `evil-terminal-cursor-changer.el` by [*el2markdown*](https://github.com/Lindydancer/el2markdown).
