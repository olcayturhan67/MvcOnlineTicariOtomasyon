FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY ["MvcOnlineTicariOtomasyon/MvcOnlineTicariOtomasyon.csproj", "MvcOnlineTicariOtomasyon/"]
RUN dotnet restore "MvcOnlineTicariOtomasyon/MvcOnlineTicariOtomasyon.csproj"

COPY . .
WORKDIR "/src/MvcOnlineTicariOtomasyon"
RUN dotnet publish -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "MvcOnlineTicariOtomasyon.dll"]