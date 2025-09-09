using GeekShopping.ProductAPI.Data.ValueObjects;

namespace GeekShopping.ProductAPI.Repository
{
    public interface IProductRepository
    {
        Task<IEnumerable<ProductVO>> FindAll();
        Task<IEnumerable<ProductVO>> FindById(long id);
        Task<IEnumerable<ProductVO>> Create(ProductVO vo);
        Task<IEnumerable<ProductVO>> Update(ProductVO vo);
        Task<IEnumerable<ProductVO>> Delete(long id);
    }
}
