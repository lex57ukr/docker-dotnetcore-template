FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /template

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
WORKDIR /template/App.Tests
ENTRYPOINT ["dotnet", "test", "--logger:trx"]

FROM build AS test
WORKDIR /template/App.Tests
RUN dotnet test

FROM test AS publish
WORKDIR /template/App
RUN dotnet publish -o out

FROM microsoft/dotnet:2.1-runtime AS runtime
WORKDIR /template
COPY --from=publish /template/App/out ./
ENTRYPOINT ["dotnet", "App.dll"]
