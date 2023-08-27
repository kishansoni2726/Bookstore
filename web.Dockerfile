FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app

############################## Server build ################################
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS serverbuild
WORKDIR /app
COPY . .
WORKDIR "/app/src/Acme.BookStore.Web"
RUN dotnet publish Acme.BookStore.Web.csproj -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=serverbuild /app/publish .
COPY certificate.pfx /https/certificate.pfx
CMD ["dotnet", "Acme.BookStore.Web.dll"]