# OrderItem.destroy_all
# Order.destroy_all
Product.destroy_all
User.destroy_all

# 1. Crea Utente Test
User.find_or_create_by!(email: 'claudio.astolfi@edu.unife.it') do |u|
  u.name = 'Claudio Astolfi'
  u.role = 1
end

User.find_or_create_by!(email: 'vendor@shop.com') do |u|
  u.name = 'Venditore Pro'
  u.role = 2
end

User.find_or_create_by!(email: 'user@shop.com') do |u|
  u.name = 'Utente Normale'
  u.role = 0
end

puts "Creati #{User.count} utenti."


# 2. Crea Prodotti
Product.create!([
  {
    title: "MacBook Pro 16",
    description: "Il MacBook Pro con chip M5 si presenta come un portatile maturo e raffinato, capace di spingere ancora più in alto gli standard già elevati della linea Pro. Le prestazioni fanno un salto deciso grazie al nuovo processore, che offre velocità superiori e una gestione dell’intelligenza artificiale molto più avanzata, pensata per lavorare in locale con rapidità e sicurezza. L’esperienza d’uso risulta fluida anche sotto carichi pesanti, merito della CPU e GPU a 10 core e della memoria unificata ottimizzata per i flussi professionali. Il display Liquid Retina XDR continua a essere uno dei punti di forza, con luminosità elevata e una resa cromatica ideale per chi lavora con contenuti visivi. Nel complesso, è un dispositivo che non rivoluziona il design, ma perfeziona ogni aspetto tecnico per offrire un equilibrio convincente tra potenza, autonomia e qualità costruttiva.",
    price: 2499.00,
    original_price: 2899.00,
    sale: true,
    thumbnail: "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=800&q=80"
  },
  {
    title: "Cuffie Sony WH-1000XM5",
    description: "Le migliori cuffie noise-cancelling sul mercato. Comfort eccezionale e 30 ore di batteria.",
    price: 349.90,
    original_price: 420.00,
    sale: true,
    thumbnail: "https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?auto=format&fit=crop&w=800&q=80"
  },
  {
    title: "Tastiera Meccanica RGB",
    description: "Switch meccanici blu, retroilluminazione personalizzabile e telaio in alluminio.",
    price: 89.99,
    original_price: 89.99,
    sale: false,
    thumbnail: "https://images.unsplash.com/photo-1595225476474-87563907a212?auto=format&fit=crop&w=800&q=80"
  },
  {
    title: "Fotocamera FujiFilm X-T5",
    description: "Stile retrò, cuore moderno. Sensore 40MP e stabilizzazione d'immagine a 5 assi.",
    price: 1699.00,
    original_price: 1850.00,
    sale: true,
    thumbnail: "https://images.unsplash.com/photo-1516035069371-29a1b244cc32?auto=format&fit=crop&w=800&q=80"
  },
  {
    title: "Smartwatch Ultra",
    description: "Cassa in titanio, GPS di precisione e resistenza all'acqua fino a 100 metri.",
    price: 799.00,
    original_price: 899.00,
    sale: true,
    thumbnail: "https://images.unsplash.com/photo-1579586337278-3befd40fd17a?auto=format&fit=crop&w=800&q=80"
  },
  {
    title: "Mouse Gaming Wireless",
    description: "Sensore ottico 20.000 DPI, latenza zero e design ultraleggero a nido d'ape.",
    price: 59.90,
    original_price: 79.90,
    sale: true,
    thumbnail: "https://images.unsplash.com/photo-1527814050087-3793815479db?auto=format&fit=crop&w=800&q=80"
  },
  {
    title: "Drone 4K Explorer",
    description: "Riprese aeree mozzafiato, evitamento ostacoli e 34 minuti di volo per batteria.",
    price: 450.00,
    original_price: 450.00,
    sale: false,
    thumbnail: "https://images.unsplash.com/photo-1473968512647-3e447244af8f?auto=format&fit=crop&w=800&q=80"
  },
  {
    title: "Monitor Curvo 34''",
    description: "Immersione totale per il lavoro e il gaming. Risoluzione WQHD e 144Hz.",
    price: 499.00,
    original_price: 650.00,
    sale: true,
    thumbnail: "https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?auto=format&fit=crop&w=800&q=80"
  },
  {
    title: "Zaino Urban Tech",
    description: "Impermeabile, scomparto imbottito per laptop e porta USB esterna per la ricarica.",
    price: 45.00,
    original_price: 60.00,
    sale: true,
    thumbnail: "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=800&q=80"
  },
  {
    title: "Occhiali da Sole Classic",
    description: "Montatura in acetato tartarugato e lenti polarizzate con protezione UV400.",
    price: 120.00,
    original_price: 120.00,
    sale: false,
    thumbnail: "https://images.unsplash.com/photo-1572635196237-14b3f281503f?auto=format&fit=crop&w=800&q=80"
  },
  {
    title: "Sneakers Limited Edition",
    description: "Design esclusivo, suola ammortizzata ad aria e materiali traspiranti.",
    price: 180.00,
    original_price: 250.00,
    sale: true,
    thumbnail: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=800&q=80"
  },
  {
    title: "Orologio Minimalista",
    description: "Cassa sottile in acciaio inossidabile e cinturino in vera pelle italiana.",
    price: 135.00,
    original_price: 135.00,
    sale: false,
    thumbnail: "https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=800&q=80"
  },

  # --- HOME & DECOR ---
  {
    title: "Lampada da Scrivania LED",
    description: "Design moderno in legno, luce calda regolabile e base antiscivolo.",
    price: 35.00,
    original_price: 50.00,
    sale: true,
    thumbnail: "https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&w=800&q=80"
  },
  {
    title: "Macchina Caffè Espresso",
    description: "Per un caffè come al bar. Pompa a 15 bar e cappuccinatore integrato.",
    price: 199.00,
    original_price: 250.00,
    sale: true,
    thumbnail: "https://images.unsplash.com/photo-1520975661595-6453be3f7070?auto=format&fit=crop&w=800&q=80"
  },
  {
    title: "Pianta Grassa in Vaso",
    description: "Succulenta decorativa con vaso in ceramica artigianale. Facile da curare.",
    price: 19.90,
    original_price: 19.90,
    sale: false,
    thumbnail: "https://images.unsplash.com/photo-1459411552884-841db9b3cc2a?auto=format&fit=crop&w=800&q=80"
  },
  {
    title: "Set Profumazione Ambiente",
    description: "Diffusore a bastoncini con essenza di lavanda e sandalo.",
    price: 24.90,
    original_price: 35.00,
    sale: true,
    thumbnail: "https://images.unsplash.com/photo-1602928321679-560bb453f190?auto=format&fit=crop&w=800&q=80"
  }
])
puts "Creati #{Product.count} prodotti."