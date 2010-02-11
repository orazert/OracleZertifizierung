1. grosse Frage
wk_cc1.id + wk_cc1.user_id bestimmen einen eindeutigen Eintrag
Ich glaube, wir koennen nicht in wk_CC1 gleichzeitig user spezifisch bilden. Doch ein anderer table wird gebraucht.
so ist WK_PERSONAL entstanden.

2. 
"Anteil an der Gruppe" ist nur bis Ebene CC3 sinnvoll, weiter nach oben wird nicht summiert

3. 
default user statistik2006, wurde bis jetzt noch nicht gebraucht

4.
Wenn ein User in z.B.CC1 den Wert eingetragen hat, soll das System verhindern, dass er wieder in den unteren Ebenen Werte einzutragen.
Ungekehrt auch so. Ansonst kann man nicht es berechnen.

ddl 11/2/2010 update:
1. add 4 Views
2. drop external tabl after import
3. insert test data to WK_USER, WK_PERSONAL for test
4. bisherige version handelt nur um vpi als beispiel

Zend:
1. Zahl mit Komma wurde falsch dargestellt in web, z.B. 
soll: 0,45
ist: ,45