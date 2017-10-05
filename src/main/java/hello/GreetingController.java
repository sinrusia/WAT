package hello;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

import com.wat.*;
import org.springframework.web.bind.annotation.*;

@RestController
public class GreetingController {

    private static final String template = "Hello, %s!";
    private final AtomicLong counter = new AtomicLong();

    List<Hero> heroes;

    public GreetingController() {
        heroes = new ArrayList<Hero>();
        heroes.add(new Hero(counter.incrementAndGet(), "Mr. Nicess"));
        heroes.add(new Hero(counter.incrementAndGet(), "Narco"));
        heroes.add(new Hero(counter.incrementAndGet(), "Bombasto"));
        heroes.add(new Hero(counter.incrementAndGet(), "Celeritas"));
        heroes.add(new Hero(counter.incrementAndGet(), "Magneta"));
        heroes.add(new Hero(counter.incrementAndGet(), "RubberMan"));
        heroes.add(new Hero(counter.incrementAndGet(), "Dynama"));
    }

    @RequestMapping("/greeting")
    public Greeting greeting(@RequestParam(value="name", defaultValue="World") String name) {
        return new Greeting(counter.incrementAndGet(),
                String.format(template, name));
    }

    @RequestMapping("/heroes")
    public @ResponseBody List<Hero> heroes() {
        return heroes;
    }

    @RequestMapping(method = RequestMethod.GET, value= "/heroes/{id}")
    public @ResponseBody Hero fetchHeroes(@PathVariable long id) {
        for(Hero hero : heroes) {
            if(hero.getId() == id) {
                return hero;
            }
        }
        return null;
    }

    @RequestMapping(method = RequestMethod.POST, value="/heroes")
    public @ResponseBody Hero createHeroes(@RequestBody Hero hero) {
        hero.setId(counter.incrementAndGet());
        heroes.add(hero);
        System.out.println("add " + hero.getName());
        return hero;
    }

    @RequestMapping(method = RequestMethod.PUT, value="/heroes/{id}")
    public int updateHeroes(@PathVariable long id, @RequestBody Hero hero) {
        for (Hero h : heroes) {
            if(h.getId() == id) {
                h.setName(hero.getName());
                break;
            }
        }
        return 1;
    }

    @RequestMapping(method = RequestMethod.DELETE, value="/heroes/{id}")
    public int deleteHeroes(@PathVariable long id) {
        for (Hero h : heroes) {
            if(h.getId() == id) {
                heroes.remove(h);
                break;
            }
        }
        System.out.println("length :: " + heroes.size());
        return 1;
    }

    @RequestMapping(method = RequestMethod.GET, value="/apps/{id}")
    public Application getWebApplication(@PathVariable String id) {
        Application appInfo = new Application();
        appInfo.setId(id);
        appInfo.setName("test");

        List<Menu> menus = new ArrayList<Menu>();
        Menu menu = new Menu();
        menu.setId("key");
        menu.setName("status");
        menu.setUrl("http://daum.net");
        menus.add(menu);
        appInfo.setMenus(menus);

        ContainerComponent root = new ContainerComponent("root", "root", "div");
        root.getChildren().add(new VisualComponent("text", "text-1", "text"));
        root.getChildren().add(new VisualComponent("text", "text-2", "text"));
        root.getChildren().add(new VisualComponent("text", "text-3", "text"));
        root.getChildren().add(new ContainerComponent("div", "div", "div"));


        appInfo.setContents(root);

        return appInfo;
    }
}