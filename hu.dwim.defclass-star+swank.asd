;;; -*- mode: Lisp; Syntax: Common-Lisp; -*-
;;;
;;; Copyright (c) 2009 by the authors.
;;;
;;; See LICENCE for details.

(load-system :hu.dwim.asdf)

(in-package :hu.dwim.asdf)

(defsystem :hu.dwim.defclass-star+swank
  :class hu.dwim.system
  :depends-on (:hu.dwim.defclass-star
               :swank)
  :components ((:module "integration"
                :components ((:file "swank")))))
