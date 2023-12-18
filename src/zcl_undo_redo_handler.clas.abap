CLASS zcl_undo_redo_handler DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES: BEGIN OF story,
             id   TYPE i,
             name TYPE string,
             rank TYPE i,
           END OF story.

    TYPES: BEGIN OF actions,
             action TYPE string,
             story  TYPE story,
           END OF actions.

    TYPES ty_actions TYPE STANDARD TABLE OF actions.

    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_undo_redo_handler IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA my_actions TYPE ty_actions.

    my_actions = VALUE #( ( action = 'c' story = VALUE #( id = 1 name = 'My Strory 1' ) )
                          ( action = 'c' story = VALUE #( id = 1 name = 'My Strory 2' ) )
                          ( action = 'u'  )
                          ( action = 'r'  )
                          ( action = 'r'  )


                          ).


     lcl_udo_redo=>create_instance(  )->handler( it_actions = my_actions ).



  ENDMETHOD.
ENDCLASS.
