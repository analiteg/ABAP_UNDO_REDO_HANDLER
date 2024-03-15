TYPES: BEGIN OF story,
         id   TYPE i,
         name TYPE string,
       END OF story.

TYPES: BEGIN OF events,
         event TYPE string,
         story  TYPE story,
       END OF events.

TYPES ty_story   TYPE STANDARD TABLE OF story.
TYPES ty_events TYPE STANDARD TABLE OF events.
