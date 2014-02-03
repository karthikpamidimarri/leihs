# language: de

Funktionalität: Bestellungen

  @javascript
  Szenario: Keine leeren Bestellungen in der Liste der Bestellungen
    Angenommen man ist "Pius"
    Angenommen es existiert eine leere Bestellung
    Dann sehe ich diese Bestellung nicht in der Liste der Bestellungen

  Szenario: Sichtbare Reiter
    Angenommen ich bin Andi
    Wenn ich mich auf der Liste der Bestellungen befinde
    Dann sehe ich die Reiter "Alle, Offen, Genehmigt, Abgelehnt"

  Szenario: Definition visierpflichtige Bestellungen
    Angenommen ich bin Andi
    Und es existiert eine visierpflichtige Bestellung
    Dann wurde diese Bestellung von einem Benutzer aus einer visierpflichtigen Gruppe erstellt
    Und diese Bestellung beinhaltet ein Modell aus einer visierpflichtigen Gruppe

  @javascript
  Szenario: Alle Bestellungen anzeigen - Reiter Alle Bestellungen
    Angenommen ich bin Andi
    Und ich mich auf der Liste der Bestellungen befinde
    Wenn ich den Reiter "Alle" einsehe
    Dann sehe ich alle visierpflichtigen Bestellungen
    Und diese Bestellungen sind nach Erstelltdatum aufgelistet

  @javascript
  Szenario: Reiter Offene Bestellungen Darstellung
    Angenommen ich bin Andi
    Und ich mich auf der Liste der Bestellungen befinde
    Wenn ich den Reiter "Offen" einsehe
    Dann sehe ich alle offenen visierpflichtigen Bestellungen
    Und ich sehe auf der Bestellungszeile den Besteller mit Popup-Ansicht der Benutzerinformationen
    Und ich sehe auf der Bestellungszeile das Erstelldatum
    Und ich sehe auf der Bestellungszeile die Anzahl Gegenstände mit Popup-Ansicht der bestellten Gegenstände
    Und ich sehe auf der Bestellungszeile die Dauer der Bestellung
    Und ich sehe auf der Bestellungszeile den Zweck
    Und ich kann die Bestellung genehmigen
    Und ich kann die Bestellung ablehnen
    Und ich kann die Bestellung editieren
    Und ich kann keine Bestellungen aushändigen

  @javascript
  Szenario: Reiter "Genehmigt" Darstellung
    Angenommen ich bin Andi
    Und ich mich auf der Liste der Bestellungen befinde
    Wenn ich den Reiter "Genehmigt" einsehe
    Dann sehe ich alle genehmigten visierpflichtigen Bestellungen
    Und ich sehe auf der Bestellungszeile den Besteller mit Popup-Ansicht der Benutzerinformationen
    Und ich sehe auf der Bestellungszeile das Erstelldatum
    Und ich sehe auf der Bestellungszeile die Anzahl Gegenstände mit Popup-Ansicht der bestellten Gegenstände
    Und ich sehe auf der Bestellungszeile die Dauer der Bestellung
    Und ich sehe auf der Bestellungszeile den Status
    Und ich kann die genehmigte Bestellung auf den Status noch nicht genehmigt zurücksetzen
    Und ich kann keine Bestellungen aushändigen

  @javascript
  Szenario: Reiter "Abgelehnt" Darstellung
    Angenommen ich bin Andi
    Und ich mich auf der Liste der Bestellungen befinde
    Wenn ich den Reiter "Abgelehnt" einsehe
    Dann sehe ich alle abgelehnten visierpflichtigen Bestellungen
    Und ich sehe auf der Bestellungszeile den Besteller mit Popup-Ansicht der Benutzerinformationen
    Und ich sehe auf der Bestellungszeile das Erstelldatum
    Und ich sehe auf der Bestellungszeile die Anzahl Gegenstände mit Popup-Ansicht der bestellten Gegenstände
    Und ich sehe auf der Bestellungszeile die Dauer der Bestellung
    Und ich sehe auf der Bestellungszeile den Status

  @javascript
  Szenario: Filter zum visieren aufheben
    Angenommen ich bin Andi
    Und ich mich auf der Liste der Bestellungen befinde
    Und ich sehe alle visierpflichtigen Bestellungen
    Wenn ich den Filter "Zu prüfen" aufhebe
    Dann sehe ich alle Bestellungen, welche von Benutzern der visierpflichtigen Gruppen erstellt wurden

  @javascript
  Szenario: Bereits genehmigte Bestellung zurücksetzen
    Angenommen ich bin Andi
    Und ich mich auf der Liste der Bestellungen befinde
    Wenn ich den Reiter "Genehmigt" einsehe
    Und ich eine bereits genehmigte Bestellung zurücksetze
    Dann ist die Bestellung wieder im Status noch nicht genehmigt
