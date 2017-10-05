package hello;

/**
 * Created by gojaehag on 2017. 7. 11..
 */
public class Hero {
    private long id;
    private String name;

    public Hero() {

    }

    public Hero(long id, String name) {
        this.id = id;
        this.name = name;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
