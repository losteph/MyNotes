% children of the root node
parent(person(first, ancestor), person(sirius, black)).
parent(person(first, ancestor), person(phineas, nigellus)).
parent(person(first, ancestor), person(elladora, black)).
parent(person(first, ancestor), person(iola, black)).


% phineas nigellus and ursula flint children
parent(person(phineas, nigellus), person(sirius, black)).
parent(person(ursula, flint), person(sirius, black)).
parent(person(phineas, nigellus), person(phineas, black)).
parent(person(ursula, flint), person(phineas, black)).
parent(person(phineas, nigellus), person(cygnus, black)).
parent(person(ursula, flint), person(cygnus, black)).
parent(person(phineas, nigellus), person(belvina, black)).
parent(person(ursula, flint), person(belvina, black)).
parent(person(phineas, nigellus), person(arcturus, black)).
parent(person(ursula, flint), person(arcturus, black)).


% sirius black and hesper gamp children
parent(person(sirius, black), person(arcturus, black)).
parent(person(hesper, gamp), person(arcturus, black)).
parent(person(sirius, black), person(lycoris, black)).
parent(person(hesper, gamp), person(lycoris, black)).
parent(person(sirius, black), person(regulus, black)).
parent(person(hesper, gamp), person(regulus, black)).


% cygnus black and violetta bulstrode children
parent(person(cygnus, black), person(pollux, black)).
parent(person(violetta, bulstrode), person(pollux, black)).
parent(person(cygnus, black), person(cassiopeia, black)).
parent(person(violetta, bulstrode), person(cassiopeia, black)).
parent(person(cygnus, black), person(marius, black)).
parent(person(violetta, bulstrode), person(marius, black)).
parent(person(cygnus, black), person(dorea, black)).
parent(person(violetta, bulstrode), person(dorea, black)).


% arcturus black and lysandra yaxley children
parent(person(arcturus, black), person(callidora, black)).
parent(person(lysandra, yaxley), person(callidora, black)).
parent(person(arcturus, black), person(cedrella, black)).
parent(person(lysandra, yaxley), person(cedrella, black)).
parent(person(arcturus, black), person(charis, black)).
parent(person(lysandra, yaxley), person(charis, black)).


% arcturus black and melania macmillan children
parent(person(arcturus, black), person(lucretia, black)).
parent(person(melania, macmillan), person(lucretia, black)).
parent(person(arcturus, black), person(orion, black)).
parent(person(melania, macmillan), person(orion, black)).


% pollux black and irma crabbe children
parent(person(pollux, black), person(walburga, black)).
parent(person(irma, crabbe), person(walburga, black)).
parent(person(pollux, black), person(alphard, black)).
parent(person(irma, crabbe), person(alphard, black)).
parent(person(pollux, black), person(cygnus, black)).
parent(person(irma, crabbe), person(cygnus, black)).


% orion black and walburga black children
parent(person(orion, black), person(sirius, black)).
parent(person(walburga, black), person(sirius, black)).
parent(person(orion, black), person(regulus, black)).
parent(person(walburga, black), person(regulus, black)).


% cygnus black and druella rosier children
parent(person(cygnus, black), person(bellatrix, black)).
parent(person(druella, rosier), person(bellatrix, black)).
parent(person(cygnus, black), person(andromeda, black)).
parent(person(druella, rosier), person(andromeda, black)).
parent(person(cygnus, black), person(narcissa, black)).
parent(person(druella, rosier), person(narcissa, black)).


% male people
male(person(phineas, nigellus)).
male(person(sirius, black)).
male(person(phineas, black)).
male(person(cygnus, black)).
male(person(herbert, burke)).
male(person(arcturus, black)).
male(person(regulus, black)).
male(person(pollux, black)).
male(person(marius, black)).
male(person(orion, black)).
male(person(alphard, black)).
male(person(cygnus, black)).
male(person(sirius, black)).
male(person(regulus, black)).
male(person(bob, hitchens)).
male(person(herbert, burke)).
male(person(harfang, longbottom)).
male(person(septimus, weasley)).
male(person(gaspar, crouch)).
male(person(charlus, potter)).
male(person(ignatius, prewett)).
male(person(rodolphus, lestrange)).
male(person(ted, tonks)).
male(person(lucius, malfoy)).


% female people
female(person(ursula, flint)).
female(person(hesper, gamp)).
female(person(violetta, bulstrode)).
female(person(elladora, black)).
female(person(iola, black)).
female(person(belvina, black)).
female(person(lysandra, yaxley)).
female(person(melania, macmillan)).
female(person(lycoris, black)).
female(person(irma, crabbe)).
female(person(cassiopeia, black)).
female(person(dorea, black)).
female(person(callidora, black)).
female(person(cedrella, black)).
female(person(charis, black)).
female(person(lucretia, black)).
female(person(walburga, black)).
female(person(druella, rosier)).
female(person(bellatrix, black)).
female(person(andromeda, black)).
female(person(narcissa, black)).


% married couples
married(person(phineas, nigellus), person(ursula, flint)).
married(person(ursula, flint), person(phineas, nigellus)).
married(person(iola, black), person(bob, hitchens)).
married(person(bob, hitchens), person(iola, black)).
married(person(sirius, black), person(hesper, gamp)).
married(person(hesper, gamp), person(sirius, black)).
married(person(cygnus, black), person(violetta, bulstrode)).
married(person(violetta, bulstrode), person(cygnus, black)).
married(person(belvina, black), person(herbert, burke)).
married(person(herbert, burke), person(belvina, black)).
married(person(arcturus, black), person(lysandra, yaxley)).
married(person(lysandra, yaxley), person(arcturus, black)).
married(person(arcturus, black), person(melania, macmillan)).
married(person(melania, macmillan), person(arcturus, black)).
married(person(callidora, black), person(harfang, longbottom)).
married(person(harfang, longbottom), person(callidora, black)).
married(person(sedrella, black), person(septimus, weasley)).
married(person(septimus, weasley), person(sedrella, black)).
married(person(charis, black), person(gaspar, crouch)).
married(person(gaspar, crouch), person(charis, black)).
married(person(dorea, crouch), person(charlus, potter)).
married(person(charlus, potter), person(dorea, black)).
married(person(lucretia, black), person(ignatius, prewett)).
married(person(ignatius, prewett), person(lucretia, black)).
married(person(cygnus, black), person(druella, rosier)).
married(person(druella, rosier), person(cygnus, black)).
married(person(bellatrix, black), person(rodolphus, lestrange)).
married(person(rodolphus, lestrange), person(bellatrix, black)).
married(person(andromeda, black), person(ted, tonks)).
married(person(ted, tonks), person(andromeda, black)).
married(person(narcissa, black), person(lucius, malfoy)).
married(person(lucius, malfoy), person(narcissa, black)).
