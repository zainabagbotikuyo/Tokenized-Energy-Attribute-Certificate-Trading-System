;; Production Tracking Contract
;; Records energy generation amounts

(define-data-var admin principal tx-sender)

;; Production records
(define-map production-records
  { id: uint }
  {
    generator-id: uint,
    amount: uint,  ;; in kWh
    timestamp: uint,
    verified: bool
  }
)

(define-data-var next-record-id uint u1)

;; Record energy production
(define-public (record-production (generator-id uint) (amount uint))
  (let ((record-id (var-get next-record-id)))
    (map-insert production-records
      { id: record-id }
      {
        generator-id: generator-id,
        amount: amount,
        timestamp: block-height,
        verified: false
      }
    )
    (var-set next-record-id (+ record-id u1))
    (ok record-id)
  )
)

;; Verify a production record (admin only)
(define-public (verify-production (record-id uint))
  (let ((record (unwrap! (map-get? production-records { id: record-id }) (err u404))))
    (asserts! (is-eq tx-sender (var-get admin)) (err u403))
    (map-set production-records
      { id: record-id }
      (merge record { verified: true })
    )
    (ok true)
  )
)

;; Get production record
(define-read-only (get-production-record (record-id uint))
  (map-get? production-records { id: record-id })
)

;; Check if production record is verified
(define-read-only (is-production-verified (record-id uint))
  (match (map-get? production-records { id: record-id })
    record (get verified record)
    false
  )
)

;; Transfer admin rights
(define-public (transfer-admin (new-admin principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u403))
    (var-set admin new-admin)
    (ok true)
  )
)
