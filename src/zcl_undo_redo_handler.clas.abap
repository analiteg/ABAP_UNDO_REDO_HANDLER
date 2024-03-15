CLASS zcl_undo_redo_handler DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES: BEGIN OF story,
             id   TYPE i,
             name TYPE string,
           END OF story.

    METHODS get_result
      IMPORTING it_events        TYPE ANY TABLE
      RETURNING VALUE(rt_result) TYPE story.

    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_undo_redo_handler IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA lt_events TYPE ty_events.

    lt_events = VALUE #( ( event = 'update' story = VALUE #( id = 1 name = 'My Strory 1' ) )
                         ( event = 'update' story = VALUE #( id = 1 name = 'My Strory 2' ) )
                         ( event = 'undo'  )
                         ( event = 'redo'  )
                         ( event = 'redo'  ) ).

    out->write( get_result( it_events = lt_events ) ).
  ENDMETHOD.

  METHOD get_result.
    rt_result = lcl_undo_redo=>create_instance( )->event_handler( it_events = it_events ).
  ENDMETHOD.
ENDCLASS.
