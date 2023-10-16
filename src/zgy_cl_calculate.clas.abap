CLASS zgy_cl_calculate DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit_calc_element_read.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zgy_cl_calculate IMPLEMENTATION.
  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA: lt_professorsData TYPE TABLE OF zgy_c_rap WITH DEFAULT KEY.

*          tüm varolan kayıtlı datayı bu itab e aktarmak için:
    lt_professorsdata = CORRESPONDING #( it_original_data ).

    LOOP AT lt_professorsdata ASSIGNING FIELD-SYMBOL(<lf_professors>).

      IF ( <lf_professors>-Role EQ 'Professor').

        <lf_professors>-BonusAmount = <lf_professors>-Salary + 500.
      ELSE.
        <lf_professors>-BonusAmount = <lf_professors>-Salary + 1000.

      ENDIF.

    ENDLOOP.

*    importing parametresi olarak it_original_data kullandıysak aynı şekilde changing parametresi olarak :
    ct_calculated_data = CORRESPONDING #( lt_professorsdata ).

  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

  ENDMETHOD.

ENDCLASS.
