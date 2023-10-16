@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'interface view entity'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zgy_i_rap
  as select from zgy_t_rap_001
{
  key id                 as Id,
      firstname          as Firstname,
      lastname           as Lastname,
      age                as Age,
      role               as Role,
      salary             as Salary,
      active             as Active,
      lastchangeat       as Lastchangeat,
      locallastchangedat as Locallastchangedat
}
