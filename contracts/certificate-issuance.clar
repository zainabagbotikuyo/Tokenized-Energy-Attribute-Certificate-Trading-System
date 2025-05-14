;; Certificate Issuance Contract
;; Creates tradable energy attribute certificates

(define-data-var admin principal tx-sender)

;; Certificate data
(define-non-fungible-token energy-certificate uint)

(define-map certificates
  { id: uint }
  {
    generator-id: uint,
    production-record-id: uint,
    amount: uint,  ;; in kWh
    issuance-date: uint,
    retired: bool
  }
)

(define-data-var next-certificate-id uint u1)

;; Issue a new certificate
(define-public (issue-certificate (generator-id uint) (production-record-id uint) (amount uint))
  (let ((certificate-id (var-get next-certificate-id)))
    (asserts! (is-eq tx-sender (var-get admin)) (err u403))

    ;; Mint the NFT
    (try! (nft-mint? energy-certificate certificate-id tx-sender))

    ;; Store certificate data
    (map-insert certificates
      { id: certificate-id }
      {
        generator-id: generator-id,
        production-record-id: production-record-id,
        amount: amount,
        issuance-date: block-height,
        retired: false
      }
    )

    (var-set next-certificate-id (+ certificate-id u1))
    (ok certificate-id)
  )
)

;; Retire a certificate
(define-public (retire-certificate (certificate-id uint))
  (let ((certificate (unwrap! (map-get? certificates { id: certificate-id }) (err u404)))
        (owner (unwrap! (nft-get-owner? energy-certificate certificate-id) (err u404))))
    (asserts! (is-eq tx-sender owner) (err u403))
    (asserts! (not (get retired certificate)) (err u401))

    (map-set certificates
      { id: certificate-id }
      (merge certificate { retired: true })
    )
    (ok true)
  )
)

;; Get certificate details
(define-read-only (get-certificate (certificate-id uint))
  (map-get? certificates { id: certificate-id })
)

;; Check if certificate is retired
(define-read-only (is-retired (certificate-id uint))
  (match (map-get? certificates { id: certificate-id })
    certificate (get retired certificate)
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
