# Oracle PL/SQL Event Management System

An academic database project developed with **Oracle SQL and PL/SQL** to organize personal events, manage users and event categories, and support common event-management operations.

The project combines **relational database design** with **procedural database programming**, including packages, stored procedures, functions, cursors, exception handling, and triggers.

## Database design

The database models users, their events, event categories, and the relationships between events and categories.


**Main tables (conceptual schema)**

| Table | Purpose |
| --- | --- |
| `Utilizatori` | Stores user information |
| `Evenimente` | Stores events and associates them with users |
| `Tipuri_evenimente` | Defines event categories |
| `Legatura_evenimente_tip` | Links events to their categories |


The `Istoric_Descrieri_Evenimente` table is used separately to save earlier descriptions when an event is updated.

## PL/SQL implementation

### Procedures, functions & packages

The project contains three PL/SQL packages:

| Package | What it does |
| --- | --- |
| `pck_utilizatori` | Adds and deletes users; counts a user's events |
| `pck_evenimente` | Updates event descriptions; checks whether an event is upcoming |
| `pck_analiza_evenimente` | Counts events, identifies the user with the most events, checks dates, and lists a user's events |

### Cursors & exception handling

- **Implicit, explicit, and parameterized cursors** for retrieving and processing records
- **Conditional logic and loops** to control PL/SQL execution
- **Built-in exceptions**, including `NO_DATA_FOUND` and `DUP_VAL_ON_INDEX`
- **Custom exceptions** for application-specific validation

### Database triggers

| Trigger | Behavior |
| --- | --- |
| `trg_check_email_format` | Checks for `@` when inserting an email address |
| `trg_prevent_delete_tip_eveniment` | Prevents deletion of event types associated with events |
| `trg_salveaza_descriere_veche` | Saves the previous event description before an update |

## Tools & concepts

**Oracle Database · Oracle SQL Developer · SQL · PL/SQL · Relational modeling · Packages · Procedures · Functions · Cursors · Exceptions · Triggers**
