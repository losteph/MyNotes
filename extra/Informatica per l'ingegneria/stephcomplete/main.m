menu = true;
w=0;
while menu == true

    scelta = input("\n 0 esci, \n 1 carica vettore, \n 2 vettore test, \n 3 bubblesort, \n 4 ordine per inserimento, \n 5 ordine per selezione, \n 6 massimo, \n 7 ricerca, \n 8 stampa vettore. \n");

    switch scelta
        
        case 0
            fprintf("uscita dal programma...");
            pause(2);
            menu = false;
            clc;
            clear all;

        case 1

            if w == 0
            [n]=dim();
            [v]=caricavet(n);
            w=1;
            else
                scelta1= input("\n un vettore è già caricato.. \n \n 1 caricare nuovo vettore, \n qualsiasi altro numero per tornare al menu \n");
                if scelta1 == 1
                        [n] = dim();
                        [v] = caricavet(n);
                   
                end
            end

        case 2
            
            if w==0
            [n,v]=vettest();
            w=2;
            elseif w == 2
                    fprintf("il vettore test è già caricato \n");
            else
                scelta2=input("è già stato caricato un vettore... \n \n 1 per caricare il vettore test \n altri numeri per tornare al menu \n");
                if scelta2 == 1
                    [n,v]=vettest();
                    w=2;
                end
            end

        case 3
            if w==0
                fprintf("inserisci prima un vettore...");
            else
           [v] = ordine1(n,v);
            end

        case 4
            if w == 0
                fprintf("inserisci prima un vettore...");
            else
            [v] = ordine2(n,v);
            end

        case 5
            if w == 0
                fprintf("inserisci prima un vettore...");
            else
            [v] = ordine3(n,v);
            end

        case 6
            massimo(n,v);

        case 7
            ricerca(n,v);
            
        case 8
           disp(v);

        otherwise
            fprintf("inserisci un numero presente nel menu \n");

    end

end