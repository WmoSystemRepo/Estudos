using GeekShopping.Web.Models;
using GeekShopping.Web.Services.IServices;
using GeekShopping.Web.Utils;

namespace GeekShopping.Web.Services
{
    public class ProductService : IProductService
    {
        private readonly HttpClient _client;
        public const string BasePath = "api/v1/product";

        public ProductService(HttpClient client)
        {
            _client = client ?? throw new
                ArgumentNullException(nameof(_client));
        }

        public async Task<IEnumerable<ProductModel>> FindAllProducts()
        {
            var reponse =  await _client.GetAsync(BasePath);
            return await reponse.ReadContentAs<List<ProductModel>>();
        }

        public async Task<ProductModel> FindProductById(long id)
        {
            var reponse = await _client.GetAsync($"{BasePath}/{id}");
            return await reponse.ReadContentAs<ProductModel>();
        }

        public async Task<ProductModel> CreateProduct(ProductModel model)
        {
            var reponse = await _client.PostAsJson(BasePath,model);
            if (reponse.IsSuccessStatusCode)
            {
                 return await reponse.ReadContentAs<ProductModel>();
            }
            else
            {
                throw new Exception("Não foi possivel fazer o cadastro!");
            }
        }

        public async Task<ProductModel> Update(ProductModel model)
        {
            var reponse = await _client.PutAsJson(BasePath, model);
            if (reponse.IsSuccessStatusCode)
            {
                return await reponse.ReadContentAs<ProductModel>();
            }
            else
            {
                throw new Exception("Não foi possivel Atualizar o cadastro!");
            }
        }

        public async Task<bool> DeleteProcductById(long id)
        {
            var reponse = await _client.DeleteAsync($"{BasePath}/{id}");

            if (reponse.IsSuccessStatusCode)
            {
                return await reponse.ReadContentAs<bool>();
            }
            else
            {
                throw new Exception("Não foi possivel Excluir o cadastro!");
            }
        }
    }
}
