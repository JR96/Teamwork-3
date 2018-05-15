deftemplate cValue (slot number))

(deffunction aAnswer (?answer ?number)
	(if (lexemep ?answer)
	then 
		(bind ?answer (lowcase ?answer))
	
		(if (or (eq ?answer "n") (eq ?answer "nickel") (eq ?answer "5") (eq ?answer "5c") )
		then 
			(bind ?answer (+ ?number 5))
		else
			(if (or (eq ?answer "q") (eq ?answer "quarter") (eq ?answer "25") (eq ?answer "25c") ) 
			then 
				(bind ?answer (+ ?number 25))
			else
				(bind ?answer ?number) 
			)
		)
	else
		(bind ?answer ?number) 
	)
	(return ?answer)
)

(defrule Start
	(declare (salience 2))
	=>
	(printout t "Starting program:" crlf crlf)
)

(defrule Process
	(declare (salience 0))
	?fact <- (cValue (number ?num))
	=>
	(printout t "Add a Nickel(5c) or a Quarter(25c): [Q or N]   --> Current amount: " ?num "c" crlf ":> ")
	(bind ?ans (readline))
		(retract ?fact)					
		(assert (cValue (number (aAnswer ?ans ?num) )))
)

(defrule End
	(declare (salience 1))
	?fact <- (cValue (number ?total))
		(test(>= ?total 35))
	=>
	(printout t "DONE !!!   --> Current amount: " ?total "c" crlf crlf crlf)
		(retract ?fact)
		(reset)
		(run)
)

(deffacts vending
	(cValue (number 0))	
)