;;; yeoman.el --- Interact with Yeoman from Emacs

;; Copyright (c) 2012 Julien Blanchard <julien@sideburns.eu>

;; Author: Julien Blanchard <julien@sideburns.eu>
;; URL: http://github.com/julienXX/
;; Keywords: yeoman node
;; Created: 02 Dec 2012
;; Version: 0.1
;; Package-Requires: ((inf-ruby "2.1"))

;; This file is NOT part of GNU Emacs.

;;; Commentary:

;; Interact with Yeoman from Emacs.
;;
;; yeoman-init      # Initialize and scaffold a new project using generator templates
;; yeoman-build     # Build an optimized version of your app, ready to deploy
;; yeoman-server    # Launch a preview server which will begin watching for changes
;; yeoman-test      # Run a Mocha test harness in a headless PhantomJS

;; yeoman-install   # Install a package from the clientside package registry
;; yeoman-uninstall # Uninstall the package
;; yeoman-update    # Update a package to the latest version
;; yeoman-list      # List the packages currently installed
;; yeoman-search    # Query the registry for matching package names
;; yeoman-lookup    # Look up info on a particular package

;;; Install

;; $ cd ~/.emacs.d/vendor
;; $ git clone git://github.com/julienXX/yeoman.el.git
;;
;; In your emacs config:
;;
;; (add-to-list 'load-path "~/.emacs.d/vendor/yeoman.el")
;; (require 'yeoman)

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

;;;###autoload
(defun yeoman-search ()
  "Search for a given package."
  (interactive)
  (let ((package-name
         (read-from-minibuffer "Package name: ")))
  (let ((search-cmd
         (format "yeoman search %s" package-name)))
  (if (string-match package-name "")
      (message "No package name provided.")
    (yeoman-command search-cmd)))))

(defun* yeoman-locate-gruntfile (&optional (dir default-directory))
  (let ((has-gruntfile (directory-files dir nil "^Gruntfile$"))
        (is-root (equal dir "/")))
    (cond
     (has-gruntfile dir)
     (is-root
      (print (format
              "No Gruntfile found in either %s or any parent directory!"
              default-directory))
      nil)
     ((yeoman-locate-gruntfile (expand-file-name ".." dir))))))

(defun yeoman-command (cmd)
  "Run cmd in an async buffer."
  (async-shell-command cmd "*Yeoman*"))

(provide 'yeoman)
