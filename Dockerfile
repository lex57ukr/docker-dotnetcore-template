FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /solution

# copy csproj and restore as distinct layers
COPY *.sln .
COPY App/*.csproj ./App/
COPY App.Tests/*.csproj ./App.Tests/
RUN dotnet restore

# copy and build everything else
COPY App/. ./App/
COPY App.Tests/. ./App.Tests/

RUN dotnet build

FROM build AS testrunner
WORKDIR /solution/App.Tests
ENTRYPOINT ["dotnet", "test", "--logger:trx"]

FROM build AS test
WORKDIR /solution/App.Tests
RUN dotnet test

FROM test AS publish
WORKDIR /solution/App
RUN dotnet publish -o out

FROM microsoft/dotnet:2.1-runtime AS runtime
WORKDIR /solution
COPY --from=publish /solution/App/out ./
ENTRYPOINT ["dotnet", "App.dll"]
