;(define-macro (delay x) `(memo-proc (lambda () ,x)))  ; memoizeあり ※stream.scmではON
(define-macro (delay x) `(lambda () ,x))               ; memoizeなし ※stream.scmではOFF
(define (force x) (x))
(define-macro (cons-stream a b) `(cons ,a (delay ,b)))
(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))
;;
;; p188
;;
; the-empty-stream, stream-null? - as in MIT Scheme's definition
(define the-empty-stream '())
(define stream-null? null?)
; stream-ref
(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))
;;
;; p189
;;
; stream-map
(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))
; stream-for-each
(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))
; display-stream, display-line
(define (display-stream s)
  (stream-for-each display-line s))
(define (display-line x)
  (newline)
  (display x))
; cons-stream, stream-car, stream-cdr → 冒頭にて定義
;;
;; p190
;;
; stream-enumerate-interval
(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream
       low
       (stream-enumerate-interval (+ low 1) high))))
; stream-filter
(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter pred
                                     (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))
;;
;; p191
;;
; delay, force → 冒頭にて定義
; memo-proc
(define (memo-proc proc)
  (let ((already-run? #f) (result #f))
    (lambda ()
      (if (not already-run?)
          (begin (set! result (proc))
                 (set! already-run? #t)
                 result)
          result))))
