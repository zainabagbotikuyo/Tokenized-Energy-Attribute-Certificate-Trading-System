;; Generator Verification Contract
;; Validates energy producers

(define-data-var admin principal tx-sender)

;; Generator status: 0 = pending, 1 = verified, 2 = rejected
(define-map generators
  { id: uint }
  {
    owner: principal,
    name: (string-utf8 100),
    location: (string-utf8 100),
    capacity: uint,
    status: uint
  }
)

(define-data-var next-generator-id uint u1)

;; Register a new generator (pending verification)
(define-public (register-generator (name (string-utf8 100)) (location (string-utf8 100)) (capacity uint))
  (let ((generator-id (var-get next-generator-id)))
    (map-insert generators
      { id: generator-id }
      {
        owner: tx-sender,
        name: name,
        location: location,
        capacity: capacity,
        status: u0
      }
    )
    (var-set next-generator-id (+ generator-id u1))
    (ok generator-id)
  )
)

;; Verify a generator (admin only)
(define-public (verify-generator (generator-id uint))
  (let ((generator (unwrap! (map-get? generators { id: generator-id }) (err u404))))
    (asserts! (is-eq tx-sender (var-get admin)) (err u403))
    (map-set generators
      { id: generator-id }
      (merge generator { status: u1 })
    )
    (ok true)
  )
)

;; Reject a generator (admin only)
(define-public (reject-generator (generator-id uint))
  (let ((generator (unwrap! (map-get? generators { id: generator-id }) (err u404))))
    (asserts! (is-eq tx-sender (var-get admin)) (err u403))
    (map-set generators
      { id: generator-id }
      (merge generator { status: u2 })
    )
    (ok true)
  )
)

;; Check if a generator is verified
(define-read-only (is-verified (generator-id uint))
  (match (map-get? generators { id: generator-id })
    generator (is-eq (get status generator) u1)
    false
  )
)

;; Get generator details
(define-read-only (get-generator (generator-id uint))
  (map-get? generators { id: generator-id })
)

;; Transfer admin rights
(define-public (transfer-admin (new-admin principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u403))
    (var-set admin new-admin)
    (ok true)
  )
)
