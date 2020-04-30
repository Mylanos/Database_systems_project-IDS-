-- vytvoření alespoň dvou netriviálních uložených procedur vč. jejich předvedení, ve kterých se musí (dohromady)
-- vyskytovat alespoň jednou kurzor, ošetření výjimek a použití proměnné s datovým typem odkazujícím se na řádek či
-- typ sloupce tabulky (table_name.column_name%TYPE nebo table_name%ROWTYPE),
CREATE OR REPLACE PROCEDURE spell_avg_strength(spell_type IN VARCHAR)
IS
    CURSOR cursor_curse IS
        SELECT S."type", S."strength"
        FROM  SPELL S;
    rec_strength SPELL."strength"%TYPE;
    rec_type SPELL."type"%TYPE;
    sum NUMBER;
    count NUMBER;
    biggest NUMBER;
BEGIN
    sum := 0;
    count := 0;
    biggest := 0;
    OPEN cursor_curse;
    LOOP
        FETCH cursor_curse INTO rec_strength, rec_type;
        EXIT WHEN cursor_curse%NOTFOUND;
            IF(rec_type = spell_type)
                THEN
                    sum := sum + rec_strength;
                    count := count + 1;
                IF(biggest < rec_strength)
                    THEN
                        biggest := rec_strength;
                END IF;
            END IF;
    END LOOP;
    CLOSE cursor_curse;
        dbms_output.put_line('Celkovo kuziel ' || count || ' najvyššia hodnota ' || biggest || ' priemer ' ||  sum / count || '');
    EXCEPTION
    WHEN ZERO_DIVIDE THEN
        dbms_output.put_line('Nenaslo sa ziadne kuzlo s danym typom!');
    WHEN OTHERS THEN
        raise_application_error(-20420, 'Nastala chyba pri vyhladani kuziel s danym typom!');
END;
/
