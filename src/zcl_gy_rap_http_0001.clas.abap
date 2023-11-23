CLASS zcl_gy_rap_http_0001 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .

    METHODS: get_html RETURNING VALUE(ui_html) TYPE string
                      RAISING
                        cx_abap_context_info_error.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_gy_rap_http_0001 IMPLEMENTATION.

  METHOD get_html.

    DATA(user_formatted_name) = cl_abap_context_info=>get_user_formatted_name( ).
    DATA(system_date) = cl_abap_context_info=>get_system_date(  ).

    ui_html = |<html> \n| &&
    |<meta charset="utf-8">| &&
    |<body> \n| &&
    |<title>Genel Bilgi</title> \n| &&
    |<p style="color:Blue;"> Merhaba, { user_formatted_name } </p> \n| &&
    |<p> Bugünün tarihi: { system_date }| &&
    |<p>| &&
    |</body> \n| &&
    |</html>|.

  ENDMETHOD.

  METHOD if_http_service_extension~handle_request.

    TRY.
        response->set_text( get_html( ) ).
      CATCH cx_web_message_error cx_abap_context_info_error.
        "handle exception
    ENDTRY.
  ENDMETHOD.



ENDCLASS.
