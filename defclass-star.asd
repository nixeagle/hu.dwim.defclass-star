;; -*- mode: Lisp; Syntax: Common-Lisp; -*-
;;;
;;; Copyright (c) 2006 by the authors.
;;;
;;; Permission is hereby granted, free of charge, to any person obtaining a copy 
;;; of this software and associated documentation files (the "Software"), to deal 
;;; in the Software without restriction, including without limitation the rights 
;;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
;;; copies of the Software, and to permit persons to whom the Software is furnished 
;;; to do so, subject to the following conditions:
;;;
;;; The above copyright notice and this permission notice shall be included in 
;;; all copies or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
;;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
;;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
;;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
;;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
;;; FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
;;; IN THE SOFTWARE.

(in-package :cl-user)

(defpackage #:defclass-star.system
  (:use :cl :asdf))

(in-package #:defclass-star.system)

(unless (find-system 'asdf-system-connections nil)
 (when (find-package 'asdf-install)
   (funcall (read-from-string "asdf-install:install") 'asdf-system-connections)))

(unless (find-system 'asdf-system-connections nil)
  (error "defclass-star requires asdf-system-connections. See 
http://www.cliki.net/asdf-system-connections for details and download
instructions."))

;; now make sure it's loaded
(operate 'load-op 'asdf-system-connections)

(defsystem :defclass-star
  :version "0.1"
  :author ("Attila Lendvai <attila.lendvai@gmail.com>")
  :maintainer ("Attila Lendvai <attila.lendvai@gmail.com>")
  :licence "Public Domain / BSD"
  :description "defclass* and friends to simplify life."
  :components
  ((:file "package")
   (:file "duplicates" :depends-on ("package"))
   (:file "defclass-star" :depends-on ("duplicates"))
   (:static-file "test.lisp")))

(defsystem #:defclass-star.test
  :description "Tests for the defclass-star system."
  :depends-on (:defclass-star :stefil)
  :components
  ((:file "test")))

(defmethod perform ((op test-op) (system (eql (find-system :defclass-star))))
  (operate 'load-op '#:defclass-star.test)
  (in-package #:defclass-star.test)
  (eval (read-from-string "(defclass-star::enable-sharp-boolean-syntax)"))
  (declaim (optimize (debug 3)))
  (warn "Enabled the #t/#f syntax in the repl thread and set (declaim (optimize (debug 3))) for easy C-c C-c'ing")
  (format t "The result of (defclass-star.test::defclass-star-tests) is:~%~%  ~A~%~%~
             For more details run from the repl and use the customized Slime inspector to inspect the results.~%~
             See http://common-lisp.net/project/stefil/ for more details about the tests.~%"
          (funcall (read-from-string "defclass-star.test::defclass-star-tests")))
  (values))

(defmethod operation-done-p ((op test-op) (system (eql (find-system :defclass-star))))
  nil)


(defsystem-connection defclass-star-and-contextl
  :requires (defclass-star contextl)
  :components ((:file "contextl-integration")))

