program ClientProject;

uses
  {$IFDEF EurekaLog}
  EMemLeaks,
  EResLeaks,
  EDebugExports,
  EDebugJCL,
  EFixSafeCallException,
  EMapWin32,
  EAppVCL,
  EDialogWinAPIMSClassic,
  EDialogWinAPIEurekaLogDetailed,
  EDialogWinAPIStepsToReproduce,
  ExceptionLog7,
  {$ENDIF EurekaLog}
  Vcl.Forms,
  Frm_MainClient in 'Frm_MainClient.pas' {FrmMainClient},
  Dtm_MainClient in 'Dtm_MainClient.pas' {DtmMainClient: TDataModule},
  Kernel.REST.Connection in 'Kernel.REST.Connection.pas',
  goxormbr.manager.dataset.adapter.base.abstract in '..\..\..\GOX_ORMLibrary\GOX_ManagerDataSet\goxormbr.manager.dataset.adapter.base.abstract.pas',
  goxormbr.manager.dataset.adapter.base in '..\..\..\GOX_ORMLibrary\GOX_ManagerDataSet\goxormbr.manager.dataset.adapter.base.pas',
  goxormbr.manager.dataset.db.adapter.clientdataset in '..\..\..\GOX_ORMLibrary\GOX_ManagerDataSet\goxormbr.manager.dataset.db.adapter.clientdataset.pas',
  goxormbr.manager.dataset.rest.adapter.clientdataset in '..\..\..\GOX_ORMLibrary\GOX_ManagerDataSet\goxormbr.manager.dataset.rest.adapter.clientdataset.pas',
  goxormbr.manager.dataset.db.adapter in '..\..\..\GOX_ORMLibrary\GOX_ManagerDataSet\goxormbr.manager.dataset.db.adapter.pas',
  goxormbr.manager.dataset.db.adapter.fdmemtable in '..\..\..\GOX_ORMLibrary\GOX_ManagerDataSet\goxormbr.manager.dataset.db.adapter.fdmemtable.pas',
  goxormbr.manager.dataset.rest.adapter.fdmemtable in '..\..\..\GOX_ORMLibrary\GOX_ManagerDataSet\goxormbr.manager.dataset.rest.adapter.fdmemtable.pas',
  goxormbr.manager.dataset.rest.adapter in '..\..\..\GOX_ORMLibrary\GOX_ManagerDataSet\goxormbr.manager.dataset.rest.adapter.pas',
  goxormbr.manager.dataset.db in '..\..\..\GOX_ORMLibrary\GOX_ManagerDataSet\goxormbr.manager.dataset.db.pas',
  goxormbr.manager.dataset.events in '..\..\..\GOX_ORMLibrary\GOX_ManagerDataSet\goxormbr.manager.dataset.events.pas',
  goxormbr.manager.dataset.fields in '..\..\..\GOX_ORMLibrary\GOX_ManagerDataSet\goxormbr.manager.dataset.fields.pas',
  goxormbr.manager.dataset in '..\..\..\GOX_ORMLibrary\GOX_ManagerDataSet\goxormbr.manager.dataset.pas',
  goxormbr.manager.dataset.rest in '..\..\..\GOX_ORMLibrary\GOX_ManagerDataSet\goxormbr.manager.dataset.rest.pas',
  goxormbr.manager.dataset.db.session in '..\..\..\GOX_ORMLibrary\GOX_ManagerDataSet\goxormbr.manager.dataset.db.session.pas',
  goxormbr.manager.dataset.rest.session in '..\..\..\GOX_ORMLibrary\GOX_ManagerDataSet\goxormbr.manager.dataset.rest.session.pas',
  goxormbr.manager.objectset.db.adapter.base.abstract in '..\..\..\GOX_ORMLibrary\GOX_ManagerObjectSet\goxormbr.manager.objectset.db.adapter.base.abstract.pas',
  goxormbr.manager.objectset.db.adapter.base in '..\..\..\GOX_ORMLibrary\GOX_ManagerObjectSet\goxormbr.manager.objectset.db.adapter.base.pas',
  goxormbr.manager.objectset.db.adapter in '..\..\..\GOX_ORMLibrary\GOX_ManagerObjectSet\goxormbr.manager.objectset.db.adapter.pas',
  goxormbr.manager.objectset.rest.adapter in '..\..\..\GOX_ORMLibrary\GOX_ManagerObjectSet\goxormbr.manager.objectset.rest.adapter.pas',
  goxormbr.manager.objectset.db in '..\..\..\GOX_ORMLibrary\GOX_ManagerObjectSet\goxormbr.manager.objectset.db.pas',
  goxormbr.manager.objectset in '..\..\..\GOX_ORMLibrary\GOX_ManagerObjectSet\goxormbr.manager.objectset.pas',
  goxormbr.manager.objectset.rest in '..\..\..\GOX_ORMLibrary\GOX_ManagerObjectSet\goxormbr.manager.objectset.rest.pas',
  goxormbr.manager.objectset.db.session in '..\..\..\GOX_ORMLibrary\GOX_ManagerObjectSet\goxormbr.manager.objectset.db.session.pas',
  goxormbr.manager.objectset.rest.session in '..\..\..\GOX_ORMLibrary\GOX_ManagerObjectSet\goxormbr.manager.objectset.rest.session.pas',
  goxormbr.engine.connection in '..\..\..\GOX_ORMLibrary\GOX_EngineConnection\goxormbr.engine.connection.pas',
  goxormbr.engine.dbconnection.firedac in '..\..\..\GOX_ORMLibrary\GOX_EngineConnection\goxormbr.engine.dbconnection.firedac.pas',
  goxormbr.engine.restconnection.wirl in '..\..\..\GOX_ORMLibrary\GOX_EngineConnection\goxormbr.engine.restconnection.wirl.pas',
  Dto.CONTACTS_00 in '..\Common\Common_Dto\Dto_Contacts\Dto.CONTACTS_00.pas',
  Dto.CONTACTS_00_01 in '..\Common\Common_Dto\Dto_Contacts\Dto.CONTACTS_00_01.pas',
  goxormbr.core.bind in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.bind.pas',
  goxormbr.core.command.abstract in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.command.abstract.pas',
  goxormbr.core.command.deleter in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.command.deleter.pas',
  goxormbr.core.command.factory in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.command.factory.pas',
  goxormbr.core.command.inserter in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.command.inserter.pas',
  goxormbr.core.command.selecter in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.command.selecter.pas',
  goxormbr.core.command.updater in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.command.updater.pas',
  goxormbr.core.consts in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.consts.pas',
  goxormbr.core.criteria.ast in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.criteria.ast.pas',
  goxormbr.core.criteria in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.criteria.pas',
  goxormbr.core.criteria.serialize in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.criteria.serialize.pas',
  goxormbr.core.dml.generator.base in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.dml.generator.base.pas',
  goxormbr.core.dml.generator.firebird in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.dml.generator.firebird.pas',
  goxormbr.core.dml.generator.mssql in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.dml.generator.mssql.pas',
  goxormbr.core.dml.generator.sqlite in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.dml.generator.sqlite.pas',
  goxormbr.core.fields in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.fields.pas',
  goxormbr.core.json.utils in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.json.utils.pas',
  goxormbr.core.mapping.attributes in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.mapping.attributes.pas',
  goxormbr.core.mapping.classes in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.mapping.classes.pas',
  goxormbr.core.mapping.exceptions in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.mapping.exceptions.pas',
  goxormbr.core.mapping.explorer in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.mapping.explorer.pas',
  goxormbr.core.mapping.popular in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.mapping.popular.pas',
  goxormbr.core.mapping.register in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.mapping.register.pas',
  goxormbr.core.mapping.repository in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.mapping.repository.pas',
  goxormbr.core.objects.helper in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.objects.helper.pas',
  goxormbr.core.objects.manager.abstract in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.objects.manager.abstract.pas',
  goxormbr.core.objects.manager in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.objects.manager.pas',
  goxormbr.core.objects.utils in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.objects.utils.pas',
  goxormbr.core.rtti.helper in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.rtti.helper.pas',
  goxormbr.core.session.abstract in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.session.abstract.pas',
  goxormbr.core.types.blob in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.types.blob.pas',
  xxxxxxxxgoxormbr.core.types.lazy in '..\..\..\GOX_ORMLibrary\GOX_Core\xxxxxxxxgoxormbr.core.types.lazy.pas',
  goxormbr.core.types.mapping in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.types.mapping.pas',
  goxormbr.core.types in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.types.pas',
  goxormbr.core.utils in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.utils.pas',
  Repository.Manager.rest in '..\Common\Common_Repository\Repository.Manager.rest.pas',
  goxormbr.core.rest.request in '..\..\..\GOX_ORMLibrary\GOX_Core\goxormbr.core.rest.request.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMainClient, FrmMainClient);
  Application.Run;
end.










































