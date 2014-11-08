(defmacro deftail (name (&rest margs) &body body)
  ;;(let ((top (gensym "top"))))
  `(defun ,name (,@margs)
     (macrolet ((,name (&rest args) 
                  ,(if margs                                         
                       ``(progn (setf ,@(mapcan #'list ',margs args)) (go top))
                       ``(go top))))
       (tagbody top
          (progn ,@body)))))

(deftail jam (a) 
  (when a
    (jam (print (rest a)))))
