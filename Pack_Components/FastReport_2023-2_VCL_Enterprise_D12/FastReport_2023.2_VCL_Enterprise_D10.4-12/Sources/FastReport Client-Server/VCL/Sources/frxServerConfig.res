        ��  ��                  S;  4   ��
 T F R X C O N F I G         0	        <?xml version="1.0" encoding="utf-8"?>
<servers configversion="2.3.0">
  <server desc="FastReport Server configuration">
    <set name="Active" value="yes" default="yes" type="bool" desc=""/>
    <set name="Name" value="FastReport Server" default="" type="string" desc=""/>
    <http desc="HTTP server settings">
      <set name="Port" value="80" default="80" type="number" desc="TCP/IP port for HTTP server"/>
      <set name="SessionTimeOut" value="600" default="600" type="number" desc="Report session timeout in seconds"/>
      <set name="SocketTimeOut" value="300" default="300" type="number" desc="Client connection timeout in seconds"/>
      <set name="ConfigRenewTimeout" value="30" default="30" type="number" desc="The configuration renew timeout"/>
      <set name="NoCacheHeader" value="yes" default="yes" type="bool" desc="Disable of the caching document by the web browser"/>
      <set name="Compression" value="yes" default="yes" type="bool" desc="Allow GZIP compression"/>
      <set name="MIC" value="yes" default="yes" type="bool" desc="Allow MD5 message integrity check"/>
      <set name="RootPath" value="..\htdocs\" default="..\htdocs\" type="folder" desc="Public document folder for documents and results"/>
      <set name="IndexFile" value="index.html" default="index.html" type="string" desc="Index page filename"/>
      <set name="Schedule" value="schedule.xml" default="schedule.xml" type="string" desc="Schedule config file"/>
      <set name="TemplatesPath" value="..\templates\" default="..\templates\" type="folder" desc="Path to folder with templates"/>
      <set name="AllowPrint" value="no" default="no" type="bool" desc="Allow print to attached network printers"/>
      <set name="BrowserPrint" value="yes" default="yes" type="bool" desc="Allow print from browser"/>
      <set name="MaxSessions" value="0" defaultvalue="0" type="number" desc="Number of maximum session threads"/>
    </http>
    <reports desc="Reporting engine settings">
      <set name="ReportsListRenewTimeout" value="180" default="180" type="number" desc="Timeout of renew the list of available reports"/>
      <set name="Path" value="..\reports\" default="..\reports\" type="folder" desc="Path to folder with the reports (*.fr3)"/>
      <set name="Temp" value="" default="" type="string" desc="Path to temporary folder"/>
      <set name="UseFileCache" value="no" default="no" type="bool" desc="Use file cache for report prepare"/>
      <set name="MaxMemSize" value="10" default="10" type="number" desc="Maximal useful memory size in megabytes"/>
      <set name="ReportsFile" value=".\reports.xml" default=".\reports.xml" type="file" desc="Path to file with reports permissions and other properties"/>
      <set name="Scripts" value="..\scripts\" defaultvalue="..\scripts\" type="folder" desc="Path to include folder of scripts for uses directive"/>
      <set name="MaxReports" value="0" defaultvalue="0" type="number" desc="Number of maximum report threads (look ahead with dialogs in reports!)"/>
    </reports>
    <exports desc="Output formats settings">
      <html desc="HTML format">
        <set name="Active" value="yes" default="yes" type="bool" desc="Enable view reports in HTML format"/>
        <set name="FixedWidth" value="yes" default="yes" type="bool" desc="Fixed width of HTML tables"/>
        <set name="Pictures" value="yes" default="yes" type="bool" desc="Enable pictures export"/>
        <set name="AllInOneFolder" value="yes" default="yes" type="bool" desc="All files will stored in one folder"/>
        <set name="Styles" value="yes" default="yes" type="bool" desc="Export styles (wysiwyg)"/>
        <set name="Navigator" value="yes" default="yes" type="bool" desc="Show page navigator on top"/>
        <set name="SinglePage" value="no" default="no" type="bool" desc="Continuous pages"/>
        <set name="Background" value="no" default="no" type="bool" desc="Export background as image"/>
        <set name="PicsFormat" value="gif" default="jpeg" type="png/jpeg/bmp/gif/emf/wmf" desc="Pictures format png/jpeg/bmp/gif/emf/wmf"/>
        <set name="URLTarget" value="" default="" type="string" desc="Target style in page URLs"/>        
        <set name="MimeType" value="text/html" default="text/html" type="string" desc=""/>        	
      </html>
      <ods desc="Open Document Spreadsheet format">
        <set name="Active" value="yes" default="yes" type="bool" desc=""/>
        <set name="Continuous" value="no" default="yes" type="bool" desc=""/>
        <set name="PageBreaks" value="yes" default="yes" type="bool" desc=""/>
        <set name="Wysiwyg" value="yes" default="yes" type="bool" desc=""/>
        <set name="Background" value="yes" default="yes" type="bool" desc=""/>
        <set name="EmptyLines" value="yes" default="yes" type="bool" desc=""/>
        <set name="MimeType" value="application/vnd.oasis.opendocument.spreadsheet" default="application/vnd.oasis.opendocument.spreadsheet" type="string" desc=""/>
      </ods>
      <odt desc="Open Document Text format">
        <set name="Active" value="yes" default="yes" type="bool" desc=""/>
        <set name="Continuous" value="no" default="yes" type="bool" desc=""/>
        <set name="PageBreaks" value="yes" default="yes" type="bool" desc=""/>
        <set name="Wysiwyg" value="yes" default="yes" type="bool" desc=""/>
        <set name="Background" value="yes" default="yes" type="bool" desc=""/>
        <set name="EmptyLines" value="yes" default="yes" type="bool" desc=""/>
        <set name="MimeType" value="application/vnd.oasis.opendocument.text" default="application/vnd.oasis.opendocument.text" type="string" desc=""/>
      </odt>
      <pdf desc="Adobe Acrobat PDF format">
        <set name="Active" value="yes" default="yes" type="bool" desc="Enable view reports in PDF format"/>
        <set name="EmbeddedFonts" value="no" default="no" type="bool" desc=""/>
        <set name="PrintOptimized" value="no" default="no" type="bool" desc=""/>
        <set name="Outline" value="yes" default="yes" type="bool" desc=""/>
        <set name="Background" value="no" default="no" type="bool" desc=""/>
        <set name="HTMLTags" value="yes" default="yes" type="bool" desc=""/>
        <set name="MimeType" value="application/pdf" default="application/pdf" type="string" desc=""/>
      </pdf>
      <rtf desc="Rich Text format">
        <set name="Active" value="yes" default="yes" type="bool" desc="Enable view reports in RTF format"/>
        <set name="PageBreaks" value="yes" default="yes" type="bool" desc=""/>
        <set name="Pictures" value="yes" default="yes" type="bool" desc=""/>
        <set name="Wysiwyg" value="yes" default="yes" type="bool" desc=""/>
        <set name="MimeType" value="application/rtf" default="application/rtf" type="string" desc=""/>
      </rtf>
      <xml desc="XML format">
        <set name="Active" value="yes" default="yes" type="bool" desc="Enable view reports in XML format"/>
        <set name="Continuous" value="no" default="yes" type="bool" desc=""/>
        <set name="Styles" value="yes" default="yes" type="bool" desc=""/>
        <set name="PageBreaks" value="yes" default="yes" type="bool" desc=""/>
        <set name="Wysiwyg" value="yes" default="yes" type="bool" desc=""/>
        <set name="Background" value="no" default="no" type="bool" desc=""/>
        <set name="EmptyLines" value="yes" default="yes" type="bool" desc=""/>
        <set name="Extension" value="xml" default="xml" type="xls/xml" desc=""/>
        <set name="SplitType" value="pages" default="pages" type="none/pages/printonprev/rowscount" desc=""/>
        <set name="SplitRowsCount" value="100" default="100" type="number" desc=""/>
        <set name="MimeType" value="application/vnd.ms-excel" default="application/vnd.ms-excel" type="string" desc=""/>
      </xml>
      <bmp desc="BMP format">
        <set name="Active" value="yes" default="yes" type="bool" desc="Enable view reports in BMP format"/>
        <set name="Crop" value="no" default="no" type="bool" desc=""/>
        <set name="Monochrome" value="no" default="no" type="bool" desc=""/>
        <set name="Resolution" value="72" default="72" type="number" desc="Resolution in dpi"/>
        <set name="SingleFile" value="no" default="no" type="bool" desc=""/>
        <set name="MimeType" value="image/bmp" default="image/bmp" type="string" desc=""/>
      </bmp>
      <jpg desc="Jpeg format">
        <set name="Active" value="yes" default="yes" type="bool" desc="Enable view reports in Jpeg format"/>
        <set name="Crop" value="no" default="no" type="bool" desc=""/>
        <set name="Monochrome" value="no" default="no" type="bool" desc=""/>
        <set name="Resolution" value="72" default="72" type="number" desc="Resolution in dpi"/>
        <set name="SingleFile" value="no" default="no" type="bool" desc=""/>
        <set name="Quality" value="90" default="90" type="number" desc="Jpeg quality"/>
        <set name="MimeType" value="image/jpeg" default="image/jpeg" type="string" desc=""/>
      </jpg>
      <gif desc="GIF format">
        <set name="Active" value="yes" default="yes" type="bool" desc="Enable view reports in GIF format"/>
        <set name="Crop" value="no" default="no" type="bool" desc=""/>
        <set name="Resolution" value="72" default="72" type="number" desc="Resolution in dpi"/>
        <set name="SingleFile" value="no" default="no" type="bool" desc=""/>
        <set name="MimeType" value="image/gif" default="image/gif" type="string" desc=""/>
      </gif>
      <tiff desc="TIFF format">
        <set name="Active" value="yes" default="yes" type="bool" desc="Enable view reports in TIFF format"/>
        <set name="Crop" value="no" default="no" type="bool" desc=""/>
        <set name="Monochrome" value="no" default="no" type="bool" desc=""/>
        <set name="Resolution" value="72" default="72" type="number" desc="Resolution in dpi"/>
        <set name="SingleFile" value="no" default="no" type="bool" desc=""/>
        <set name="MimeType" value="image/tiff" default="image/tiff" type="string" desc=""/>
      </tiff>
      <csv desc="CSV table text format">
        <set name="Active" value="yes" default="yes" type="bool" desc="Enable view reports in CSV format"/>
        <set name="Separator" value=";" default=";" type="string" desc=""/>
        <set name="OEMCodepage" value="no" default="no" type="bool" desc=""/>
        <set name="MimeType" value="application/csv" default="application/csv" type="string" desc=""/>
      </csv>
      <txt desc="Plain text format">
        <set name="Active" value="yes" default="yes" type="bool" desc="Enable view reports in text format"/>
        <set name="PageBreaks" value="yes" default="yes" type="bool" desc=""/>
        <set name="Frames" value="no" default="no" type="bool" desc=""/>
        <set name="EmptyLines" value="no" default="no" type="bool" desc=""/>
        <set name="OEMCodepage" value="no" default="no" type="bool" desc=""/>
        <set name="MimeType" value="text/plain" default="text/plain" type="string" desc=""/>
      </txt>
      <fp3 desc="FastReport native format">
        <set name="Active" value="yes" default="yes" type="bool" desc="Enable view native FastReport format"/>
        <set name="MimeType" value="application/fastreport" default="application/fastreport" type="string" desc=""/>
      </fp3>
    </exports>
    <cache desc="Cache settings">
      <set name="Active" value="yes" default="yes" type="bool" desc="Enable caching of the reports with same parameters"/>
      <set name="Path" value="..\cache\" default="..\cache\" type="folder" desc="Path to the chache folder"/>
      <set name="DefaultLatency" value="300" default="300" type="number" desc="Default delay for cache of the report results in seconds"/>
      <set name="Target" value="memory" default="memory" type="memory/disk" desc="Target of cache spool placement"/>
    </cache>
    <logs desc="Log settings">
      <set name="Active" value="yes" default="yes" type="bool" desc="Enable of log writing"/>
      <set name="Path" value="..\logs\" default="..\logs\" type="folder" desc="Path to folder with logs"/>
      <set name="RotateFiles" value="5" default="5" type="number" desc="Maximum log files in history"/>
      <set name="RotateSize" value="1024" default="1024" type="number" desc="Maximum log file size in Kb"/>
      <set name="AccessLog" value="access.log" default="access.log" type="string" desc="Access log"/>
      <set name="ErrorLog" value="error.log" default="error.log" type="string" desc="Errors log"/>
      <set name="AgentLog" value="agent.log" default="agent.log" type="string" desc="Agents log"/>
      <set name="RefererLog" value="referer.log" default="referer.log" type="string" desc="Referers log"/>
      <set name="ServerLog" value="server.log" default="server.log" type="string" desc="Server log"/>
      <set name="AuthLog" value="auth.log" default="auth.log" type="string" desc="Authentifications log"/>
      <set name="SchedulerLog" value="scheduler.log" default="scheduler.log" type="string" desc="Scheduler log"/>
    </logs>
    <security desc="Security settings">
      <set name="Login" value="" default="" type="string" desc="Login"/>
      <set name="Password" value="" default="" type="string" desc="Password"/>
      <set name="ReportsList" value="yes" default="yes" type="bool" desc="Allow list of the available reports"/>
      <set name="AllowFile" value=".\allow.conf" default="allow.conf" type="file" desc="File with list of allowed IP addreses"/>
      <set name="DenyFile" value=".\deny.conf" default="deny.conf" type="file" desc="File with list of denied IP addreses"/>
      <set name="UserAuth" value="no" default="no" type="bool" desc="Allow user authentification"/>
      <set name="WinAuth" value="no" default="no" type="bool" desc="Allow windows authentification"/>
      <set name="CGIAuth" value="no" default="no" type="bool" desc="Allow parent CGI authentification"/>
      <set name="RemoteAuth" value="no" default="no" type="bool" desc="Allow parent CGI/Remote authentification"/>
      <set name="CookieAuth" value="no" default="no" type="bool" desc="Allow CGI/Cookie authentification"/>
      <set name="UsersFile" value=".\users.xml" default=".\users.xml" type="file" desc="Path to file with users permissions"/>
    </security>
    <scheduler desc="Schedule settings">
      <set name="Active" value="yes" default="yes" type="bool" desc="Enable of scheduler"/>
      <set name="Debug" value="no" default="no" type="bool" desc="Enable writing of debug information in log"/>
      <set name="StudioPath" value="" default="" type="string" desc="Path to FastReport Studio executable, leave blank for default path"/>
    </scheduler>
    <database desc="DB connection settings">
      <set name="Type" value="ADO" default="ADO" type="ADO" desc=""/>
      <set name="Connection" value="FR Demo Base" default="" type="string" desc="Alias connection name"/>
    </database>
  </server>
</servers>
 