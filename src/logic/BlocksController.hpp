#ifndef LOGIC_BLOCKS_CONTROLLER_HPP_
#define LOGIC_BLOCKS_CONTROLLER_HPP_

#include "../typedefs.hpp"
#include "../maths/fastmaths.hpp"
#include "../voxels/voxel.hpp"

#include <functional>
#include <glm/glm.hpp>

class Player;
class Block;
class Level;
class Chunks;
class Lighting;

enum class BlockInteraction {
    step,
    destruction,
    placing
};

using on_block_interaction = std::function<void(
    Player*, glm::ivec3, const Block*, BlockInteraction type
)>;

class Clock {
    int tickRate;
    int tickParts;

    float tickTimer = 0.0f;
    int tickId = 0;
    int tickPartsUndone = 0;
public:
    Clock(int tickRate, int tickParts);

    bool update(float delta);

    int getParts() const;
    int getPart() const;
    int getTickRate() const;
    int getTickId() const;
};

/* BlocksController manages block updates and block data (aka inventories) */
class BlocksController {
    Level* level;
	Chunks* chunks;
	Lighting* lighting;
    Clock randTickClock;
    Clock blocksTickClock;
    Clock worldTickClock;
    uint padding;
    FastRandom random;
    std::vector<on_block_interaction> blockInteractionCallbacks;
public:
    BlocksController(Level* level, uint padding);

    void updateSides(int x, int y, int z);
    void updateBlock(int x, int y, int z);

    void breakBlock(Player* player, const Block* def, int x, int y, int z);
    void placeBlock(Player* player, const Block* def, blockstate state, int x, int y, int z);

    void update(float delta);
    void randomTick(int tickid, int parts);
    void onBlocksTick(int tickid, int parts);
    int64_t createBlockInventory(int x, int y, int z);
    void bindInventory(int64_t invid, int x, int y, int z);
    void unbindInventory(int x, int y, int z);

    void onBlockInteraction(
        Player* player,
        glm::ivec3 pos,
        const Block* def,
        BlockInteraction type
    );

    void listenBlockInteraction(const on_block_interaction& callback);
};

#endif // LOGIC_BLOCKS_CONTROLLER_HPP_
