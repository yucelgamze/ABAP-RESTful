@EndUserText.label: 'consumption view entity'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zgy_c_rap
  provider contract transactional_query
  as projection on zgy_i_rap
{
      @EndUserText.label: 'ID'
  key Id,
      @EndUserText.label: 'Firstname'
      @Search.defaultSearchElement: true
      Firstname,
      @EndUserText.label: 'Lastname'
      @Search.defaultSearchElement: true
      Lastname,
      @EndUserText.label: 'Age'
      Age,
      @EndUserText.label: 'Role'
      @Search.defaultSearchElement: true
      Role,
      @EndUserText.label: 'Salary'
      Salary,
      @EndUserText.label: 'Active'
      Active,
      @Semantics.systemDateTime.lastChangedAt: true
      @EndUserText.label:'Last Change At'
      Lastchangeat,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      @EndUserText.label: 'Local Last Change At'
      Locallastchangedat,


//    virtual element ile BonusAmount için class oluşturup dinamik ekleme yapmak:

      
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZGY_CL_CALCULATE'
      @EndUserText.label: 'Total Pay'
      virtual BonusAmount : abap.int4
}
