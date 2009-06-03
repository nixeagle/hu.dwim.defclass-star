;; -*- mode: Lisp; Syntax: Common-Lisp; -*-
;;;
;;; Copyright (c) 2006 by the authors.
;;;
;;; See LICENCE for details.

(in-package #:defclass-star.system)

(defpackage :defclass-star
  (:nicknames #:defclass*)
  (:use :cl)
  (:export
   #:defclass*
   #:defcondition*
   
   #:default-accessor-name-transformer
   #:dwim-accessor-name-transformer
   #:default-initarg-name-transformer
   #:default-slot-definition-transformer
   #:make-name-transformer
   #:*allowed-slot-definition-properties*
   
   ;; more or less public vars (it's discouraged to set them globally)
   #:*accessor-name-transformer*
   #:*automatic-accessors-p*
   #:*initarg-name-transformer*
   #:*automatic-initargs-p*
   ))


