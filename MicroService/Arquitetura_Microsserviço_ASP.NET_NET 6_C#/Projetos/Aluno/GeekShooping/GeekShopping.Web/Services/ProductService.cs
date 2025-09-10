using GeekShopping.Web.Models;
using GeekShopping.Web.Services.IServices;
using GeekShopping.Web.Utils;

namespace GeekShopping.Web.Services
{
    public class ProductService : IProductService
    {
        private readonly HttpClient _client;
        public const string BasePath = "api/v1/product";

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
            throw new NotImplementedException();
        }

        public async Task<ProductModel> Update(ProductModel model)
        {
            throw new NotImplementedException();
        }

        public async Task<bool> DeleteProcductById(long id)
        {
            throw new NotImplementedException();
        }
    }
}
