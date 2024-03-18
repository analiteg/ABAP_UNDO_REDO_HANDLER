CLASS lcl_undo_redo DEFINITION CREATE PRIVATE.

  PUBLIC SECTION.
    METHODS event_handler
      IMPORTING it_events       TYPE ANY TABLE
      RETURNING VALUE(rt_result) TYPE story.

    METHODS update
      IMPORTING is_story TYPE story.

    METHODS undo.

    METHODS redo.

    CLASS-METHODS create_instance
      RETURNING VALUE(ro_instance) TYPE REF TO lcl_undo_redo.

  PRIVATE SECTION.
    CLASS-DATA lo_instance TYPE REF TO lcl_undo_redo.

    DATA lt_result TYPE ty_story.
    DATA lt_undo   TYPE ty_story.
    DATA lt_redo   TYPE ty_story.

ENDCLASS.


CLASS lcl_undo_redo IMPLEMENTATION.
  METHOD create_instance.
    ro_instance = COND #( WHEN ro_instance IS BOUND
                          THEN ro_instance
                          ELSE NEW lcl_undo_redo( ) ).
  ENDMETHOD.

  METHOD event_handler.
    LOOP AT it_events ASSIGNING FIELD-SYMBOL(<fs_events>).
      ASSIGN COMPONENT 'EVENT'  OF STRUCTURE <fs_events> TO FIELD-SYMBOL(<fs_event>).
      ASSIGN COMPONENT 'STORY'  OF STRUCTURE <fs_events> TO FIELD-SYMBOL(<fs_story>).

      CASE <fs_event>.
        WHEN 'write'.
          update( <fs_story> ).
        WHEN 'undo'.
          undo( ).
        WHEN 'redo'.
          redo( ).
        WHEN 'others'.
          EXIT.
      ENDCASE.

    ENDLOOP.
    rt_result = lt_result[ 1 ].
  ENDMETHOD.

  METHOD update.
    IF lines( lt_result ) > 0.
      APPEND lt_result[ 1 ] TO lt_undo.
      DELETE lt_result INDEX 1.
    ENDIF.
    APPEND is_story TO lt_result.
  ENDMETHOD.

  METHOD undo.
    IF lines( lt_undo ) > 0.
      APPEND lt_result[ 1 ] TO lt_redo.
      DELETE lt_result INDEX 1.
      APPEND lt_undo[ lines( lt_undo ) ] TO lt_result.
      DELETE lt_undo INDEX lines( lt_undo ).
    ENDIF.
  ENDMETHOD.

  METHOD redo.
    IF lines( lt_redo ) > 0.
      APPEND lt_result[ 1 ] TO lt_undo.
      DELETE lt_result INDEX 1.
      APPEND lt_redo[ lines( lt_redo ) ] TO lt_result.
      DELETE lt_redo INDEX lines( lt_redo ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
