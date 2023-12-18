CLASS lcl_udo_redo DEFINITION CREATE PRIVATE.

  PUBLIC SECTION.
    TYPES: BEGIN OF story,
             id   TYPE i,
             name TYPE string,
             rank TYPE i,
           END OF story.

    TYPES ty_story TYPE STANDARD TABLE OF story.

    METHODS handler
      IMPORTING it_actions TYPE ANY TABLE.

    METHODS change
      IMPORTING is_story TYPE story.

    METHODS undo.

    METHODS redo.

    CLASS-METHODS create_instance
      RETURNING VALUE(ro_instance) TYPE REF TO lcl_udo_redo.

  PRIVATE SECTION.
    CLASS-DATA lo_instance TYPE REF TO lcl_udo_redo.

    DATA lt_result TYPE ty_story.
    DATA lt_undo   TYPE ty_story.
    DATA lt_redo   TYPE ty_story.

ENDCLASS.


CLASS lcl_udo_redo IMPLEMENTATION.
  " Single tone
  METHOD create_instance.
    ro_instance = COND #( WHEN ro_instance IS BOUND
                          THEN ro_instance
                          ELSE NEW lcl_udo_redo( ) ).
  ENDMETHOD.

  METHOD handler.
    LOOP AT it_actions ASSIGNING FIELD-SYMBOL(<fs_actions>).
      ASSIGN COMPONENT 'ACTION' OF STRUCTURE <fs_actions> TO FIELD-SYMBOL(<fs_action>).
      ASSIGN COMPONENT 'STORY' OF STRUCTURE <fs_actions> TO FIELD-SYMBOL(<fs_story>).

      CASE <fs_action>.
        WHEN 'c'.
          change( <fs_story> ).
        WHEN 'u'.
          undo( ).
        WHEN 'r'.
          redo( ).
        WHEN 'others'.
          EXIT.
      ENDCASE.

    ENDLOOP.
  ENDMETHOD.

  METHOD change.
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
