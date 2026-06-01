# Shop App — Backend

Rails 8.1 API per l'applicazione e-commerce Shop App.

**Repository frontend:** https://github.com/CIaudi0/shop-frontend  
**Documentazione completa (setup, API, schema DB):** vedi il README del repository backend, che contiene anche i file `docker-compose*.yml` e il `Makefile`.

---

## Stack

- Ruby 3.2.3
- Rails 8.1.2 (API mode)
- PostgreSQL 15
- Autenticazione: Google OAuth2 (OmniAuth) + JWT
- Web server: Puma (dev) / Thruster + Puma (prod)

## Avvio rapido con Docker

```bash
# Dalla directory radice (che contiene docker-compose.yml)
make dev       # modalità sviluppo
make prod      # modalità produzione
```

## Avvio senza Docker

```bash
bundle install
bin/rails db:prepare   # crea DB + migrazioni
bin/rails server
```

## Variabili d'ambiente richieste (`backend/.env`)

```
GOOGLE_CLIENT_ID=<id>.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=<secret>
RAILS_MASTER_KEY=<contenuto di config/master.key>
```

## Endpoint principali

| Metodo | Path | Auth | Descrizione |
|--------|------|------|-------------|
| `GET` | `/products` | No | Catalogo prodotti (`?q=` per ricerca) |
| `GET` | `/products/:id` | No | Dettaglio prodotto |
| `GET` | `/cart` | Sì | Carrello utente |
| `POST` | `/cart/add/:product_id` | Sì | Aggiungi al carrello |
| `DELETE` | `/cart/remove/:product_id` | Sì | Rimuovi dal carrello |
| `PATCH` | `/cart/update/:product_id` | Sì | Aggiorna quantità |
| `POST` | `/cart/sync` | Sì | Sincronizza carrello locale |
| `GET` | `/orders` | Sì | Storico ordini |
| `POST` | `/orders` | Sì | Crea ordine dal carrello |
| `GET` | `/admin/users` | Admin | Lista utenti |
| `PATCH` | `/admin/users/:id` | Admin | Modifica ruolo |
| `DELETE` | `/admin/users/:id` | Admin | Elimina utente |
| `POST` | `/vendor/products` | Vendor | Crea prodotto |
| `PATCH` | `/vendor/products/:id` | Vendor | Modifica prodotto |
| `DELETE` | `/vendor/products/:id` | Vendor | Elimina prodotto |

Le richieste autenticate richiedono l'header `Authorization: Bearer <jwt>`.
