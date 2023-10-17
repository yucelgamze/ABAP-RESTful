CLASS lhc_Professor DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Professor RESULT result.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR professor RESULT result.

    METHODS setactive FOR MODIFY
      IMPORTING keys FOR ACTION professor~setactive RESULT result.

    METHODS changesalary FOR DETERMINE ON MODIFY
      IMPORTING keys FOR professor~changesalary.

    METHODS validateage FOR VALIDATE ON SAVE
      IMPORTING keys FOR professor~validateage.


ENDCLASS.

CLASS lhc_Professor IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

    METHOD get_instance_features.

    "active y ise setActive action butonu disabled olacak
    "active n ise setActive action butonu enabled olacak

    READ ENTITIES OF zgy_i_rap IN LOCAL MODE
    ENTITY Professor
    FIELDS ( Active ) WITH CORRESPONDING #( keys )
    RESULT DATA(fieldactived)
    FAILED failed.

    result = VALUE #( FOR field IN fieldactived
    LET activeval = COND #( WHEN field-Active = abap_true
                            THEN if_abap_behv=>fc-o-disabled
                            ELSE if_abap_behv=>fc-o-enabled )

                            IN ( %tky = field-%tky
                                 %action-setActive = activeval )
    ).

  ENDMETHOD.


  METHOD setActive.

    "action button active etmek için

    MODIFY ENTITIES OF zgy_i_rap IN LOCAL MODE
    ENTITY Professor
    UPDATE
    FIELDS ( Active )
    WITH VALUE #( FOR key IN keys ( %tky = key-%tky    Active = abap_true ) )

    FAILED failed
    REPORTED reported.

    "update işleminden sonra veri okumalı:

    READ ENTITIES OF zgy_i_rap IN LOCAL MODE
    ENTITY Professor
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(fielddata).

    result = VALUE #( FOR data IN fielddata

                    (  %tky   = data-%tky
                       %param = data )
    ).

  ENDMETHOD.


  METHOD changeSalary.

    "determination

    READ ENTITIES OF zgy_i_rap IN LOCAL MODE
    ENTITY Professor
    FIELDS ( Salary )
    WITH CORRESPONDING #( keys )
    RESULT DATA(salarydata).

    LOOP AT salarydata INTO DATA(salary).

      CASE salary-Role.
        WHEN 'Professor'.
          MODIFY ENTITIES OF zgy_i_rap IN LOCAL MODE
          ENTITY Professor
          UPDATE
          FIELDS ( Salary ) WITH VALUE #( ( %tky = salary-%tky Salary = 90 ) ).
        WHEN 'Teacher'.
          MODIFY ENTITIES OF zgy_i_rap IN LOCAL MODE
          ENTITY Professor
          UPDATE
          FIELDS ( Salary ) WITH VALUE #( ( %tky = salary-%tky Salary = 60 ) ).
      ENDCASE.


    ENDLOOP.

  ENDMETHOD.

  METHOD validateAge.

    READ ENTITIES OF zgy_i_rap IN LOCAL MODE
    ENTITY Professor
    FIELDS ( Age ) WITH CORRESPONDING #( keys )
    RESULT DATA(fieldagedata).

    LOOP AT fieldagedata INTO DATA(agedata).

      IF agedata-Age < 24.
        APPEND VALUE #( %tky = agedata-%tky ) TO failed-professor.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                        %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                      text     = '24 den küçük yaş giremezsiniz! ' )
                       ) to reported-professor.
      ENDIF.

      ENDLOOP.

    ENDMETHOD.

ENDCLASS.
