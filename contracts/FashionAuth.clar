;; FashionAuth - Luxury Item Authentication System
;; Allows brands to mint authentication certificates for luxury items

(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-already-exists (err u102))
(define-constant err-unauthorized (err u103))

;; Data structures
(define-map authenticated-items
  { item-id: uint }
  {
    brand: principal,
    model: (string-ascii 50),
    serial-number: (string-ascii 30),
    manufacture-date: uint,
    authenticator: principal,
    is-authentic: bool
  }
)

(define-map brand-registry
  { brand: principal }
  {
    name: (string-ascii 50),
    verified: bool,
    registration-date: uint
  }
)

(define-data-var next-item-id uint u1)

;; Register a brand
(define-public (register-brand (name (string-ascii 50)))
  (let ((brand-data {
    name: name,
    verified: true,
    registration-date: stacks-block-height
  }))
    (map-set brand-registry { brand: tx-sender } brand-data)
    (ok true)
  )
)

;; Authenticate an item
(define-public (authenticate-item 
  (brand principal)
  (model (string-ascii 50))
  (serial-number (string-ascii 30))
  (manufacture-date uint))
  (let ((item-id (var-get next-item-id)))
    (asserts! (is-some (map-get? brand-registry { brand: brand })) err-not-found)
    (asserts! (is-none (map-get? authenticated-items { item-id: item-id })) err-already-exists)
    
    (map-set authenticated-items
      { item-id: item-id }
      {
        brand: brand,
        model: model,
        serial-number: serial-number,
        manufacture-date: manufacture-date,
        authenticator: tx-sender,
        is-authentic: true
      }
    )
    (var-set next-item-id (+ item-id u1))
    (ok item-id)
  )
)

;; Verify item authenticity
(define-read-only (verify-item (item-id uint))
  (map-get? authenticated-items { item-id: item-id })
)

;; Get brand info
(define-read-only (get-brand-info (brand principal))
  (map-get? brand-registry { brand: brand })
)

;; Get next item ID
(define-read-only (get-next-item-id)
  (var-get next-item-id)
)
