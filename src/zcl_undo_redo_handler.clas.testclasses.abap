CLASS ltc_undo_redo_handler DEFINITION FOR TESTING
RISK LEVEL HARMLESS
DURATION SHORT.

  PRIVATE SECTION.
    DATA f_cut TYPE REF TO zcl_undo_redo_handler.

    METHODS setup.
    METHODS event_handler FOR TESTING.

ENDCLASS.


CLASS ltc_undo_redo_handler IMPLEMENTATION.
  METHOD setup.
    f_cut = NEW zcl_undo_redo_handler( ).
  ENDMETHOD.

  METHOD event_handler.
    DATA lt_events  TYPE ty_events.
    DATA exp_result TYPE story.

    lt_events = VALUE #( ( event = 'update'  story = VALUE #( id = 1 name = 'My Strory 1' ) )
                         ( event = 'update' story = VALUE #( id = 1 name = 'My Strory 2' ) )
                         ( event = 'undo'  )
                         ( event = 'redo'  )
                         ( event = 'redo'  ) ).

    exp_result = VALUE #( id = 1 name = 'My Strory 2' ).
    DATA(my_result) = f_cut->get_result( it_events = lt_events ).
    cl_abap_unit_assert=>assert_equals( act = my_result
                                        exp = exp_result ).
  ENDMETHOD.
ENDCLASS.
