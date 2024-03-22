import List "mo:base/List";
import Option "mo:base/Option";
import Trie "mo:base/Trie";
import Nat32 "mo:base/Nat32";


actor SuperHeroes{

  public type SuperheroId=Nat32;

  public type Superhero = {
    name:Text;
    superPowers:List.List<Text>;
  };

  private stable var next: SuperheroId=0;

  private stable var superheroes:Trie.Trie<SuperheroId,Superhero> = Trie.empty();

  public func create(superhero:Superhero): async SuperheroId {
    let superheroId = next;
    next +=1;
    superheroes := Trie.replace(
      superheroes,
      key(superheroId),
      Nat32.equal,
      ?superhero,
    ).0;
    superheroId
  };

  public query func read (superheroId:SuperheroId):async ?Superhero{

    let result = Trie.find(superheroes,key(superheroId),Nat32.equal);
    result
  };

  public func update(superheroId:SuperheroId,superhero:Superhero): async Bool {

      let result = Trie.find(superheroes,key(superheroId),Nat32.equal);
      let exist = Option.isSome(result);
      if (exist){
        superheroes := Trie.replace(
          superheroes,
          key(superheroId),
          Nat32.equal,
          ?superhero,

        ).0;

      };

      exist

  };

   public func delete(superheroId:SuperheroId,superhero:Superhero): async Bool {

      let result = Trie.find(superheroes,key(superheroId),Nat32.equal);
      let exist = Option.isSome(result);
      if (exist){
        superheroes := Trie.replace(
          superheroes,
          key(superheroId),
          Nat32.equal,
          ?superhero,

        ).0;

      };

      exist

  };


  private func key(x:SuperheroId): Trie.Key<SuperheroId>{

    {hash = x; key =x};
  };




};
