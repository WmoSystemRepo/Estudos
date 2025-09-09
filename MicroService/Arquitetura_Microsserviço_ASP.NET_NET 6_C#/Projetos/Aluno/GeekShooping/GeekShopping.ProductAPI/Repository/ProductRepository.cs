using AutoMapper;
using GeekShopping.ProductAPI.Data.ValueObjects;
using GeekShopping.ProductAPI.Model;
using GeekShopping.ProductAPI.Model.Context;
using Microsoft.EntityFrameworkCore;

namespace GeekShopping.ProductAPI.Repository
{
    public class ProductRepository : IProductRepository
    {
        private readonly MySqlContext _context;
        private IMapper _mapper;

        public ProductRepository(MySqlContext context, IMapper mapper )
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<IEnumerable<ProductVO>> FindAll()
        {
            List<Product> products = await _context.Products.ToListAsync();
            return _mapper.Map<IEnumerable<ProductVO>>( products );
        }

        public async Task<ProductVO> FindById(long id)
        {
            Product products = 
                await _context.Products.Where(p => p.Id == id)
                .FirstOrDefaultAsync();

            return _mapper.Map<ProductVO>(products);
        }

        public Task<IEnumerable<ProductVO>> Create(ProductVO vo)
        {
            throw new NotImplementedException();
        }
                public Task<IEnumerable<ProductVO>> Update(ProductVO vo)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<ProductVO>> Delete(long id)
        {
            throw new NotImplementedException();
        }    
    }
}
