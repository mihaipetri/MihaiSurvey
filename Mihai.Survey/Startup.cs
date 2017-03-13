using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Mihai.Survey.Startup))]
namespace Mihai.Survey
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
