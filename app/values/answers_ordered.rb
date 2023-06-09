class AnswersOrdered
  def create_guesses
    current_date = "2021-06-19".to_date

    to_a.each do |answer_word|
      answer_word = answer_word.downcase
      ap "adding '#{answer_word}' on #{current_date}"
      begin
        Guess.add_word_to_empty_day(answer_word, current_date)
      rescue => e
        ap e.message
      end
      current_date = current_date + 1.day
    end
  end

  def to_a
    %w{
      CIGAR
      REBUT
      SISSY
      HUMPH
      AWAKE
      BLUSH
      FOCAL
      EVADE
      NAVAL
      SERVE
      HEATH
      DWARF
      MODEL
      KARMA
      STINK
      GRADE
      QUIET
      BENCH
      ABATE
      FEIGN
      MAJOR
      DEATH
      FRESH
      CRUST
      STOOL
      COLON
      ABASE
      MARRY
      REACT
      BATTY
      PRIDE
      FLOSS
      HELIX
      CROAK
      STAFF
      PAPER
      UNFED
      WHELP
      TRAWL
      OUTDO
      ADOBE
      CRAZY
      SOWER
      REPAY
      DIGIT
      CRATE
      CLUCK
      SPIKE
      MIMIC
      POUND
      MAXIM
      LINEN
      UNMET
      FLESH
      BOOBY
      FORTH
      FIRST
      STAND
      BELLY
      IVORY
      SEEDY
      PRINT
      YEARN
      DRAIN
      BRIBE
      STOUT
      PANEL
      CRASS
      FLUME
      OFFAL
      AGREE
      ERROR
      SWIRL
      ARGUE
      BLEED
      DELTA
      FLICK
      TOTEM
      WOOER
      FRONT
      SHRUB
      PARRY
      BIOME
      LAPEL
      START
      GREET
      GONER
      GOLEM
      LUSTY
      LOOPY
      ROUND
      AUDIT
      LYING
      GAMMA
      LABOR
      ISLET
      CIVIC
      FORGE
      CORNY
      MOULT
      BASIC
      SALAD
      AGATE
      SPICY
      SPRAY
      ESSAY
      FJORD
      SPEND
      KEBAB
      GUILD
      ABACK
      MOTOR
      ALONE
      HATCH
      HYPER
      THUMB
      DOWRY
      OUGHT
      BELCH
      DUTCH
      PILOT
      TWEED
      COMET
      JAUNT
      ENEMA
      STEED
      ABYSS
      GROWL
      FLING
      DOZEN
      BOOZY
      ERODE
      WORLD
      GOUGE
      CLICK
      BRIAR
      GREAT
      ALTAR
      PULPY
      BLURT
      COAST
      DUCHY
      GROIN
      FIXER
      GROUP
      ROGUE
      BADLY
      SMART
      PITHY
      GAUDY
      CHILL
      HERON
      VODKA
      FINER
      SURER
      RADIO
      ROUGE
      PERCH
      RETCH
      WROTE
      CLOCK
      TILDE
      STORE
      PROVE
      BRING
      SOLVE
      CHEAT
      GRIME
      EXULT
      USHER
      EPOCH
      TRIAD
      BREAK
      RHINO
      VIRAL
      CONIC
      MASSE
      SONIC
      VITAL
      TRACE
      USING
      PEACH
      CHAMP
      BATON
      BRAKE
      PLUCK
      CRAZE
      GRIPE
      WEARY
      PICKY
      ACUTE
      FERRY
      ASIDE
      TAPIR
      TROLL
      UNIFY
      REBUS
      BOOST
      TRUSS
      SIEGE
      TIGER
      BANAL
      SLUMP
      CRANK
      GORGE
      QUERY
      DRINK
      FAVOR
      ABBEY
      TANGY
      PANIC
      SOLAR
      SHIRE
      PROXY
      POINT
      ROBOT
      PRICK
      WINCE
      CRIMP
      KNOLL
      SUGAR
      WHACK
      MOUNT
      PERKY
      COULD
      WRUNG
      LIGHT
      THOSE
      MOIST
      SHARD
      PLEAT
      ALOFT
      SKILL
      ELDER
      FRAME
      HUMOR
      PAUSE
      ULCER
      ULTRA
      ROBIN
      CYNIC
      AROMA
      CAULK
      SHAKE
      DODGE
      SWILL
      TACIT
      OTHER
      THORN
      TROVE
      BLOKE
      VIVID
      SPILL
      CHANT
      CHOKE
      RUPEE
      NASTY
      MOURN
      AHEAD
      BRINE
      CLOTH
      HOARD
      SWEET
      MONTH
      LAPSE
      WATCH
      TODAY
      FOCUS
      SMELT
      TEASE
      CATER
      MOVIE
      SAUTE
      ALLOW
      RENEW
      THEIR
      SLOSH
      PURGE
      CHEST
      DEPOT
      EPOXY
      NYMPH
      FOUND
      SHALL
      STOVE
      LOWLY
      SNOUT
      TROPE
      FEWER
      SHAWL
      NATAL
      COMMA
      FORAY
      SCARE
      STAIR
      BLACK
      SQUAD
      ROYAL
      CHUNK
      MINCE
      SHAME
      CHEEK
      AMPLE
      FLAIR
      FOYER
      CARGO
      OXIDE
      PLANT
      OLIVE
      INERT
      ASKEW
      HEIST
      SHOWN
      ZESTY
      TRASH
      LARVA
      FORGO
      STORY
      HAIRY
      TRAIN
      HOMER
      BADGE
      MIDST
      CANNY
      SHINE
      GECKO
      FARCE
      SLUNG
      TIPSY
      METAL
      YIELD
      DELVE
      BEING
      SCOUR
      GLASS
      GAMER
      SCRAP
      MONEY
      HINGE
      ALBUM
      VOUCH
      ASSET
      TIARA
      CREPT
      BAYOU
      ATOLL
      MANOR
      CREAK
      SHOWY
      PHASE
      FROTH
      DEPTH
      GLOOM
      FLOOD
      TRAIT
      GIRTH
      PIETY
    }
  end
end
