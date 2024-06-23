{ Copyright (C) 1998-2011, written by Mike Shkolnik, Scalabium Software
  E-Mail: mshkolnik@scalabium
  WEB: http://www.scalabium.com

  Const strings for localization
  freeware SMComponent library
}
unit SMCnst;

interface

{Slovak strings}
{Na verziu SMComponent library v3.9 upravil Peter Kopèa - AZsoft - azsoft@azsoft.sk}
{v4.00, oprava prekladu, 20.7.2020, mklacansky77@gmail.com}

const
  strMessage = 'Tlaè...';
  strSaveChanges = 'Uloi zmeny?';
  strErrSaveChanges = 'Nie je moné vykona zápis!!!';
  strDeleteWarning = 'Naozaj chcete vymaza tabu¾ku %s?';
  strEmptyWarning = 'Naozaj chcete vyprázdni tabu¾ku %s?';

const
  PopUpCaption: array [0..24] of string[50] =
   ('Novı záznam',
    'Vloi záznam',
    'Opravi záznam',
    'Vymaza záznam',
    '-',
    'Tlaè...',
    'Export...',
    'Filter...',
    'H¾ada...',
    '-',
    'Uloi zmeny',
    'Vráti zmeny',
    'Znovu naèíta...',
    '-',
    'Oznaèi/Odznaèi záznamy',
       'Oznaèi záznam',
       'Oznaèi všetky záznamy',
       '-',
       'Odznaèi záznam',
       'Odznaèi všetky záznamy',
    '-',
    'Uloi štruktúru ståpcov',
    'Naèíta štruktúru ståpcov',
    '-',
    'Nastavenie...');
    
const //for TSMSetDBGridDialog
  SgbTitle = ' Titulok ';
  SgbData = ' Dáta ';
  STitleCaption = 'Nadpis:';
  STitleAlignment = 'Zarovnanie:';
  STitleColor = 'Pozadie:';
  STitleFont = 'Písmo:';
  SWidth = 'Šírka:';
  SWidthFix = 'znaky';
  SAlignLeft = 'v¾avo';
  SAlignRight = 'vpravo';
  SAlignCenter = 'na stred';

const //for TSMDBFilterDialog
  strEqual = 'rovná sa';
  strNonEqual = 'nerovná sa';
  strNonMore = 'je menší alebo sa rovná';
  strNonLess = 'je väèší alebo sa rovná';
  strLessThan = 'menší ako';
  strLargeThan = 'väèší ako';
  strExist = 'prázdny';
  strNonExist = 'nie je prázdny';
  strIn = 'nachádza sa v';
  strBetween = 'je v rozsahu';
  strLike = 'obsahuje';

  strOR = 'alebo';
  strAND = 'a súèasne';

  strField = 'Poloka';
  strCondition = 'Podmienka';
  strValue = 'Hodnota';

  strAddCondition = ' Definovanie dodatoènej podmienky: ';
  strSelection = ' Zoznam záznamov pre následné podmienky:';

  strAddToList = 'Prida do zoznamu';
  strEditInList = 'Upravi v zozname';
  strDeleteFromList = 'Odstráni zo zoznamu';

  strTemplate = 'Filter vzorového dialógu';
  strFLoadFrom = 'Naèíta z...';  // New constatns
  strFSaveAs = 'Uloi ako..';
  strFDescription = 'Popis';
  strFFileName = 'Názov';
  strFCreate = 'Vytvorené: %s';
  strFModify = 'Upravené: %s';
  strFProtect = 'Zamedzi prepísaniu';
  strFProtectErr = 'Súbor nie je moné prepísa!';

const //for SMDBNavigator
  SFirstRecord = 'Prvı záznam';
  SPriorRecord = 'Predchádzajúci záznam';
  SNextRecord = 'Nasledujúci záznam';
  SLastRecord = 'Poslednı záznam';
  SInsertRecord = 'Vloi záznam';
  SCopyRecord = 'Kopírova záznam';
  SDeleteRecord = 'Vymaza záznam';
  SEditRecord = 'Upravi záznam';
  SFilterRecord = 'Filtrovacia podmienka';
  SFindRecord = 'H¾ada v záznamoch';
  SPrintRecord = 'Tlaèi záznamy';
  SExportRecord = 'Exportova záznamy';
  SImportRecord = 'Importova záznamy';
  SPostEdit = 'Uloi zmeny';
  SCancelEdit = 'Zruši zmeny';
  SRefreshRecord = 'Obnovi dáta';
  SChoice = 'Vybra záznam';
  SClear = 'Odstraòujem vybrané záznamy';
  SDeleteRecordQuestion = 'Vymaza záznam?';
  SDeleteMultipleRecordsQuestion = 'Skutoène chcete vymaza vybrané záznamy?';
  SRecordNotFound = 'Záznam sa nenašiel';

  SFirstName = 'Prvı záznam';
  SPriorName = 'Predchádzajúci záznam';
  SNextName = 'Nasledujúci záznam';
  SLastName = 'Poslednı záznam';
  SInsertName = 'Vloi záznam';
  SCopyName = 'Kopírova záznam';
  SDeleteName = 'Vymaza záznam';
  SEditName = 'Upravi záznam';
  SFilterName = 'Filtrovacia podmienka';
  SFindName = 'H¾ada v záznamoch';
  SPrintName = 'Tlaè záznamov';
  SExportName = 'Export záznamov';
  SImportName = 'Import záznamov';
  SPostName = 'Uloi zmeny';
  SCancelName = 'Zruši';
  SRefreshName = 'Obnovi´záznamy';
  SChoiceName = 'Vybra záznam';
  SClearName = 'Odstráni vybrané záznamy';

  SBtnOk = '&OK';
  SBtnCancel = '&Zruši';
  SBtnLoad = 'Naèíta';
  SBtnSave = 'Uloi';
  SBtnCopy = 'Kopírova';
  SBtnPaste = 'Vloi';
  SBtnClear = 'Odstráni';

  SRecNo = 'záz.';
  SRecOf = ' z ';

const //for EditTyped
  etValidNumber = 'platné èíslo';
  etValidInteger = 'platná num. hodnota';
  etValidDateTime = 'platnı dátum/èas';
  etValidDate = 'platnı dátum';
  etValidTime = 'platnı èas';
  etValid = 'platnı';
  etIsNot = 'Nie je';
  etOutOfRange = 'Hodnota %s je mimo rozsah %s..%s';

  SApplyAll = 'Poui na všetko';

  SNoDataToDisplay = '<iadne údaje>';

  SPrevYear = 'predchádzajúci rok';
  SPrevMonth = 'predchádzajúci mesiac';
  SNextMonth = 'nasledujúci mesiac';
  SNextYear = 'nasledujúci rok';

implementation

end.
