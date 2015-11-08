#lang racket
(require 2htdp/batch-io 2htdp/universe 2htdp/image)
(require test-engine/racket-gui)

(define SCENE (empty-scene 200 200))

(define LIGHT-RADIUS 10)
(define X-POS 50)
(define Y-POS-RED 50)
(define Y-POS-YELLOW 75)
(define Y-POS-GREEN 100)

(define ON-RED-LIGHT (circle LIGHT-RADIUS "solid" "red"))
(define OFF-RED-LIGHT (circle LIGHT-RADIUS "solid" "tomatoe"))

(define ON-GREEN-LIGHT (circle LIGHT-RADIUS "solid" "green"))
(define OFF-GREEN-LIGHT (circle LIGHT-RADIUS "solid" "GreenYellow"))

(define ON-YELLOW-LIGHT (circle LIGHT-RADIUS "solid" "yellow"))
(define OFF-YELLOW-LIGHT (circle LIGHT-RADIUS "solid" "LemonChiffon"))

(define (RED-ON-TRAFFIC-LIGHT)
  (overlay/offset
   (overlay/offset ON-RED-LIGHT 0 25
                   OFF-YELLOW-LIGHT)
   0 35
   OFF-GREEN-LIGHT)
  )

(define (YELLOW-ON-TRAFFIC-LIGHT)
  (overlay/offset
   (overlay/offset OFF-RED-LIGHT 0 25
                   ON-YELLOW-LIGHT)
   0 35
   OFF-GREEN-LIGHT)
  )

(define (GREEN-ON-TRAFFIC-LIGHT)
  (overlay/offset
   (overlay/offset OFF-RED-LIGHT 0 25
                   OFF-YELLOW-LIGHT)
   0 35
   ON-GREEN-LIGHT)
  )

(define (traffic-light-simulation s)
  (big-bang s
    [on-tick traffic-light-next]
    [to-draw render-traffic-light]))

(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))
  

(define (render-traffic-light s)
  (display s)
  (cond
    ((string=? s "red") (RED-ON-TRAFFIC-LIGHT))
    ((string=? s "yellow") (YELLOW-ON-TRAFFIC-LIGHT))
    ((string=? s "green") (GREEN-ON-TRAFFIC-LIGHT))))

(traffic-light-simulation "red")

(check-expect (traffic-light-next "red") "yellow")