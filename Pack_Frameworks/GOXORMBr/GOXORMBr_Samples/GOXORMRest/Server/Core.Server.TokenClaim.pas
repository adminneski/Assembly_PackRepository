{******************************************************************************}
{                                                                              }
{       WiRL: RESTful Library for Delphi                                       }
{                                                                              }
{       Copyright (c) 2015-2018 WiRL Team                                      }
{                                                                              }
{       https://github.com/delphi-blocks/WiRL                                  }
{                                                                              }
{******************************************************************************}
unit Core.Server.TokenClaim;

interface

uses
  System.Classes,
  WiRL.Core.JSON,
  WiRL.Core.Auth.Context;

type
  // Custom Claims Class
  TKernelServerTokenClaim = class(TWiRLSubject)
  private
    const CLAIM_CLIENT_USER                    = 'client_user';
    const CLAIM_CLIENT_PASSWORD                = 'client_password';
    const CLAIM_CLIENT_COMPANY_CODIGO          = 'client_company_codigo';
    const CLAIM_CLIENT_MAC_NETWORKCARD         = 'client_mac_networkcard';
    const CLAIM_CLIENT_IP_INTERNET             = 'client_ip_internet';
    //
  private
    function GetClientUser: String;
    procedure SetClientUser(const Value: String);
    function GetClientPassword: String;
    procedure SetClientPassword(const Value: String);
    function GetClientCompanyCodigo: String;
    procedure SetClientCompanyCodigo(const Value: String);
    function GetClient_IpInternet: String;
    procedure SetClient_IpInternet(const Value: String);
  public
    property CLIENT_USER: String read GetClientUser write SetClientUser;
    property CLIENT_PASSWORD: String read GetClientPassword write SetClientPassword;
    property CLIENT_COMPANY_CODIGO: String read GetClientCompanyCodigo write SetClientCompanyCodigo;
    property ClIENT_IP_INTERNET: String read GetClient_IpInternet write SetClient_IpInternet;
    //
  end;

implementation

uses
  JOSE.Types.JSON,
  JOSE.Core.Base;

{ TKernelServerTokenClaim }


function TKernelServerTokenClaim.GetClient_IpInternet: String;
begin
  Result := TJSONUtils.GetJSONValue(CLAIM_CLIENT_IP_INTERNET, FJSON).AsString;
end;

function TKernelServerTokenClaim.GetClientCompanyCodigo: String;
begin
  Result := TJSONUtils.GetJSONValue(CLAIM_CLIENT_COMPANY_CODIGO, FJSON).AsString;
end;


function TKernelServerTokenClaim.GetClientPassword: String;
begin
  Result := TJSONUtils.GetJSONValue(CLAIM_CLIENT_PASSWORD, FJSON).AsString;
end;

function TKernelServerTokenClaim.GetClientUser: String;
begin
  Result := TJSONUtils.GetJSONValue(CLAIM_CLIENT_USER, FJSON).AsString;
end;


procedure TKernelServerTokenClaim.SetClient_IpInternet(const Value: String);
begin
  if Value = '' then
    TJSONUtils.RemoveJSONNode(CLAIM_CLIENT_IP_INTERNET, FJSON)
  else
    TJSONUtils.SetJSONValueFrom<string>(CLAIM_CLIENT_IP_INTERNET, Value, FJSON);
end;

procedure TKernelServerTokenClaim.SetClientCompanyCodigo(
  const Value: String);
begin
  if Value = '' then
    TJSONUtils.RemoveJSONNode(CLAIM_CLIENT_COMPANY_CODIGO, FJSON)
  else
    TJSONUtils.SetJSONValueFrom<string>(CLAIM_CLIENT_COMPANY_CODIGO, Value, FJSON);
end;

procedure TKernelServerTokenClaim.SetClientPassword(const Value: String);
begin
  if Value = '' then
    TJSONUtils.RemoveJSONNode(CLAIM_CLIENT_PASSWORD, FJSON)
  else
    TJSONUtils.SetJSONValueFrom<string>(CLAIM_CLIENT_PASSWORD, Value, FJSON);
end;

procedure TKernelServerTokenClaim.SetClientUser(const Value: String);
begin
  if Value = '' then
    TJSONUtils.RemoveJSONNode(CLAIM_CLIENT_USER, FJSON)
  else
    TJSONUtils.SetJSONValueFrom<string>(CLAIM_CLIENT_USER, Value, FJSON);

end;

end.
