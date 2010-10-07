;;; ebm.el ---

;; Copyright (C) 2010 ryebread

;; Author:
;; Created:
;; Version: HEAD

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:


;;; Feature Request:

;;; Code:

(eval-when-compile (require 'cl))
(require 'parse-time)
(when (> 22 emacs-major-version)
  (setq load-path
	(append (mapcar (lambda (dir)
			  (expand-file-name
			   dir
			   (if load-file-name
			       (or (file-name-directory load-file-name)
				   ".")
			     ".")))
			'("url-emacs21" "emacs21"))
		load-path))
  (and (require 'un-define nil t)
       ;; the explicitly require 'unicode to update a workaround with
       ;; navi2ch.
       (require 'unicode nil t)))
(require 'url)

(defconst ebm-version "HEAD")

(defun ebm-version ()
  "Display a message for ebm version."
  (interactive)
  (let ((version-string
	 (format "ebm-v%s" ebm-version)))
    (if (interactive-p)
	(message "%s" version-string)
      version-string)))

(defvar ebm-dir "~/.emacs.d/ebm"
  "The directory of ebm books")

(defvar ebm-view-books t
  "whether display books window")

(defvar ebm-view-index t
  "whether display index windows")

(defvar ebm-scroll-speed 30
  "ebm scroll book speed")

(defvar ebm-display-font-size 150
  "Percent of the display font size")

(defvar ebm-curl-program nil
  "Cache a result of `ebm-find-curl-program'.
DO NOT SET VALUE MANUALLY.")
(defvar ebm-curl-program-https-capability nil
  "Cache a result of `ebm-start-http-session-curl-https-p'.
DO NOT SET VALUE MANUALLY.")

(defvar ebm-wget-program nil
  "Cache a result of `ebm-find-wget-program'.
DO NOT SET VALUE MANUALLY.")


(defvar ebm-connection-type-order '(curl wget native))
  "*A list of connection methods in the preferred order."

(defvar ebm-connection-type-table
  '((native (check . t)
	    (https . ebm-start-http-session-native-tls-p)
	    (send-http-request . ebm-send-http-request-native)
	    (oauth-get-token . native)
	    (pre-process-buffer . ebm-pre-process-buffer-native))
    (curl (check . ebm-start-http-session-curl-p)
	  (https . ebm-start-http-session-curl-https-p)
	  (send-http-request . ebm-send-http-request-curl)
	  (oauth-get-token . curl)
	  (pre-process-buffer . ebm-pre-process-buffer-curl))
    (wget (check . ebm-start-http-session-wget-p)
	  (https . t)
	  (send-http-request . ebm-send-http-request-wget)
	  (oauth-get-token . wget)
	  (pre-process-buffer . ebm-pre-process-buffer-wget)))
  "A list of alist of connection methods.")

(defun ebm-show-books()
  "Ebm show the books list"
  (interactive)
  )

;;;###autoload
(defun ebm()
  (interactive)
  (ebm-show-books))

(provide 'ebm)
;;; ebm.el ends here
