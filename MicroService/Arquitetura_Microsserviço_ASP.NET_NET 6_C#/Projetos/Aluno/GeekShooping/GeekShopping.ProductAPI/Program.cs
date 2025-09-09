using AutoMapper;
using GeekShopping.ProductAPI.Config;
using GeekShopping.ProductAPI.Model.Context;
using GeekShopping.ProductAPI.Repository;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// String de conexão MySQL (ajuste conforme seu appsettings.json)
var connection = builder.Configuration["MySqlConnection:MySqlConnectionString"];

// Configura o DbContext
builder.Services.AddDbContext<MySqlContext>(options =>
    options.UseMySql(connection, ServerVersion.AutoDetect(connection)));

// Configuração e registro do AutoMapper
var mappingConfig = MappingConfig.RegisterMaps();
IMapper mapper = mappingConfig.CreateMapper();
builder.Services.AddSingleton(mapper);

// Registro do ProductRepository na DI
builder.Services.AddScoped<IProductRepository, ProductRepository>();

// Controllers e documentação Swagger
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseAuthorization();

app.MapControllers();

app.Run();
