(defparameter *reponse*
	'(
		(( je vais * x ) (Pourquoi allez vous x ? ))
		((je deteste * y) (Qu'est ce qui fait que vous detestez y ?))
		((j'adore * z) (pourquoi adorez vous z ?))
    ((J'ai envie de * a)(pourquoi avez vous envie de a ?))
	) 
)



(defun match-eq (list1 list2)
  (if (and (null list1) (null list2))
      t
      (and (not (null list1)) (not (null list2))
           (equal (car list1) (car list2))
           (match-eq (cdr list1) (cdr list2)
            )
      )
  )
)

(defparameter *bindings* NIL) 

(defparameter *subLetter* NIL)

(defun chercherSub (key alist)   
	(when (and (not(null key)) (atom key) (listp alist) (not(null alist)) )
		(if (equal (car alist) key)
			(car alist)
			(chercherSub key (cdr alist))
		)
	) ;chercher un atome dans une liste pour subLetter
)


(defun inverse (list)
	(if (null list) list
	(append (inverse (cdr list)) (list (car list)))
	)   ;inverse
)




; decomposeDerriere renvoie " bien " si en entree la fonction a 
;" vais super archi " et " moi jordan lucas vais super archi bien "
;si en deuxièlme arg on avait " moi jordan lucas vais super duper archi bien " elle renvoie NIL
(defun decomposeDerriere (list1 list2 )   
	(if (null list1)
		list2
		(if(null list2)
			list2
			(if(equal (car list2) (car list1))
				(decomposeDerriere (cdr list1) (cdr list2))
				(decomposeDerriere list1 (cdr list2))
			)
		)
	)
)


(defun decomposeDevant(list1 list2)
	(inverse (decomposeDerriere (inverse list1) (inverse list2)))    ;decomposeDevant
)

;isolate isole la base du motif
;la fonction renverra "adore les" pour "* x adore les * y" en entree
; on prend aussi en compte les cas ou l'arg est "* x adore manger "
; ou "jordan lucas adore * y"
(defun isolate (list)
	(if(equal(car list) '*) ;si le premier atome est *
		(if (equal(car(cdr(inverse list))) '*)   ;si l'avant dernier atome de la list est *
			(inverse(cdr(cdr(inverse(cdr(cdr list))))))
			(cdr(cdr list))
		)
		(if (equal(car(cdr(inverse list))) '*)   ;si l'avant dernier atome de la list est *
			(inverse(cdr(cdr(inverse list))))
			list
		)
	)
)

  ;match

(defun match (list1 list2)
  (when (and list1 list2)
    (let ((front (decomposeDevant (isolate list1) list2))
          (back (decomposeDerriere (isolate list1) list2)))
      (cond
        ;; cas de figure exemple : (match '(* x vais super * y) '(je vais super bien))
        ;; push ((x je) (y bien))
        ((and front back (equal (car list1)'*) (equal (cadr (reverse list1))'*))
         (push (cons (cadr list1) front) *bindings*)
         (push (cons (car (reverse list1)) back) *bindings*)
         (push (cadr list1) *subLetter*)
         (push (car (reverse list1)) *subLetter*)
         t)
        ;; cas de figure exemple : (match '(* x vais super * y) '(je vais super))
        ;; push ((x je) (y))
        ((and front (null back) (equal (car list1)'*) (equal (cadr (reverse list1))'*))
         (push (cons (cadr list1) front) *bindings*)
         (push (list (car (reverse list1))) *bindings*)
         (push (cadr list1) *subLetter*)
         (push (car (reverse list1)) *subLetter*)
         t)
        ;; cas de figure exemple : (match '(* x vais super * y) '(vais super bien))
        ;; push ((x) (y bien))
        ((and (null front) back (equal (car list1)'*) (equal (cadr (reverse list1))'*))
         (push (cons (car (reverse list1)) back) *bindings*)
         (push (cadr list1) *bindings*)
         (push (cadr list1) *subLetter*)
         (push (car (reverse list1)) *subLetter*)
         t)
        ;; cas de figure exemple : (match '(* x vais super bien) '(je vais super bien))
        ;; push ((x je))
        ((and (equal (car list1)'*) (not(equal (cadr (reverse list1))'*)) front)
         (push (cons (cadr list1) front) *bindings*)
         (push (cadr list1) *subLetter*)
         t)
        ;; cas de figure exemple : (match '(je vais super * y) '(je vais super bien))
        ;; push ((y bien))
        ((and (not(equal (car list1)'*)) (equal (cadr (reverse list1))'*) back)
         (push (cons (car (reverse list1)) back) *bindings*)
         (push (car (reverse list1)) *subLetter*)
         t)
        ;; cas de figure exemple : (match '(je vais super * y) '(je vais super))
        ;; push ((y))
        ((and (not(equal (car list1)'*)) (equal (cadr (reverse list1))'*) (null back))
         (if (match-eq (isolate list1) list2)
             (progn
               (push (list(car (reverse list1))) *bindings*)
               (push (car (reverse list1)) *subLetter*)
               t)
         nil
         )
        )
        ;; cas de figure exemple : (match '(* x je vais super) '(je vais super))
        ;; push ((x))
        ((and (equal (car list1)'*) (not(equal (cadr (reverse list1))'*)) (null front))
         (if (match-eq (isolate list1) list2)
             (progn
               (push (list(cadr list1)) *bindings*)
               (push (cadr list1) *subLetter*)
               t)
			nil
			)
        )
      )
    )
  )
)  ;; return nil if none of the conditions above match


(defun chercher (key alist)
	(when (atom key)
		(if (equal(car(car alist)) key)
			(car alist)
			(chercher key (cdr alist))
		)
	)  ;chercher
)

;subsub cherche si un des atome correspond bien à un des bindings puis renvoi l'atome remplacé par le bindings correspondant 
;avec le reste des atomes de la liste en entrée si il y en a.
;nil si il n'y a pas d'atome correspondant au bindings
(defun subsub(alist)    
	(when (not(null alist))
		(if (not (null (chercherSub (car alist) *subLetter*)))
			(append (cdr(chercher (car alist) *bindings*)) (cdr alist))
			(subsub (cdr alist))
		)
	)
)


;subsub cherche si un des atome correspond bien à un des bindings puis
;renvoi le debut de la liste coupé (exlu) à partir de l'atome 
(defun subsub2 (alist)
	(when (not(null alist))
		(if (not (null (chercherSub (car (inverse alist)) *subLetter*)))
			(inverse (cdr(inverse alist)))
			(subsub2 (inverse(cdr(inverse alist))))
		)
	)
)

;si subsub et subsub2 sont non nulles, on append les 2  
;
(defun subs (alist)
	(if (and(not(null (subsub alist))) (not(null (subsub2 alist))))
		(append (subsub2 alist)(subsub alist))
		(if (and(not(null (subsub alist))) (null(subsub2 alist)))
			(subsub alist)
		)
	)
)


(defun start-eliza ()
  (loop
    (princ "YOU> ")
    (let* ((line (read-line))
           (input (read-from-string (concatenate 'string "(" line ")"))))
      (when (string= line "bye") (return))
      (format t "ELIZA> ~{~(~a ~)~}~%"
              (dolist (r *reponse*)
                (when (match (car r) input)
                	(push '(hd ds) *bindings*)	 
                  (return (subs (cadr r))))
                )
      
      )

    )
  )
)

(start-eliza)







;j'ai encore un petit problème avec le match
;il fait tres bien ce qu'il est censé faire mais pour m'aider pour sub, j'ai cree une nouvelle variable globale *subLetter*
;elle repertorie tout les noms des bindings ajouté dans une liste.
;si avec match, on a *bindings* = (x albertine la duchesse) alors on ajoute a *subLetter* x
;subs marche avec ce système.
;finalement le gros est fait et je pense avoir bien pris en main le langage 
;les fonctions ne sont pas optimisées (surtout match avec tt ces let et if)






