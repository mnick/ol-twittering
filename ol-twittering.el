;;; ol-twittering.el --- Links to tweets in twitterin-mode

;; Copyright (C) 2019  Maximilian Nickel

;; Author: Maximilian Nickel <max.nickel@gmail.com>
;; Keywords: outlines, hypermedia, calendar, twitter


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

;;; Code:

(require 'ol)
(require 'org)
(require 'twittering-mode)

(defun org-twittering-store-link ()
  "Store a link to a tweet."
  (when (eq major-mode 'twittering-mode)
    (let* ((username (get-text-property (point) 'username))
           (text (get-text-property (point) 'text))
           (id (get-text-property (point) 'id))
           (status (twittering-find-status id))
           (url (twittering-get-status-url-from-alist status))
           (link (org-link-store-props
                  :type "twit"
                  :link (format "twit:%s" id)
                  :description (format "Tweet from %s" username))))
      (org-link-add-props :from username
                          :tweet text
                          :url url
                          :message-id id)
      link)))

(defun org-twittering-open (tweet-id)
  "Open twitterting link to TWEET-ID in browser."
  (let* ((status (twittering-find-status tweet-id))
         (url (twittering-get-status-url-from-alist status)))
    (browse-url url)))

(org-link-set-parameters
 "twit"
 :follow #'org-twittering-open
 :store #'org-twittering-store-link)

(provide 'ol-twittering)

;;; ol-twittering.el ends here
