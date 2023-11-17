-- CreateTable
CREATE TABLE `ability` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `description` VARCHAR(255) NOT NULL,
    `min` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `max` TINYINT UNSIGNED NOT NULL DEFAULT 99,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `appearance` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `required` BOOLEAN NOT NULL,
    `min` INTEGER NULL,
    `max` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `appearance_value` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `appearance_id` INTEGER NOT NULL,
    `value` VARCHAR(255) NOT NULL,

    INDEX `appearance_id`(`appearance_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `formation` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `defenders` INTEGER NOT NULL,
    `midfielders` INTEGER NOT NULL,
    `forwards` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `league` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `league_category_id` INTEGER NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `real_name` VARCHAR(255) NULL,

    INDEX `league_category_id`(`league_category_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `league_category` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `nationality` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `player` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nationality_id` INTEGER NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `real_name` VARCHAR(255) NULL,
    `strip_name` VARCHAR(255) NOT NULL,

    INDEX `nationality_id`(`nationality_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `players_abilities` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `player_id` INTEGER NOT NULL,
    `ability_id` INTEGER NOT NULL,
    `value` INTEGER NOT NULL,

    INDEX `ability_id`(`ability_id`),
    INDEX `player_id`(`player_id`),
    UNIQUE INDEX `player_id_2`(`player_id`, `ability_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `players_appearances` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `player_id` INTEGER NOT NULL,
    `appearance_id` INTEGER NOT NULL,
    `appearance_value_id` INTEGER NULL,
    `value` INTEGER NULL,

    INDEX `appearance_id`(`appearance_id`),
    INDEX `appearance_value_id`(`appearance_value_id`),
    UNIQUE INDEX `player_id`(`player_id`, `appearance_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `players_positions` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `player_id` INTEGER NOT NULL,
    `position_id` INTEGER NOT NULL,
    `registered` BOOLEAN NOT NULL,

    INDEX `player_id`(`player_id`),
    INDEX `position_id`(`position_id`),
    UNIQUE INDEX `player_id_2`(`player_id`, `position_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `players_settings` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `player_id` INTEGER NOT NULL,
    `setting_id` INTEGER NOT NULL,
    `setting_value_id` INTEGER NULL,
    `value` INTEGER NULL,

    INDEX `setting_id`(`setting_id`),
    INDEX `setting_value_id`(`setting_value_id`),
    UNIQUE INDEX `player_id`(`player_id`, `setting_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `players_special_abilities` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `player_id` INTEGER NOT NULL,
    `special_ability_id` INTEGER NOT NULL,
    `active` BOOLEAN NOT NULL,

    INDEX `special_ability_id`(`special_ability_id`),
    UNIQUE INDEX `player_id`(`player_id`, `special_ability_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `players_teams` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `player_id` INTEGER NOT NULL,
    `team_id` INTEGER NOT NULL,
    `starter` BOOLEAN NOT NULL,
    `captain` BOOLEAN NOT NULL,
    `long_fk_taker` BOOLEAN NOT NULL,
    `short_fk_taker` BOOLEAN NOT NULL,
    `left_ck_taker` BOOLEAN NOT NULL,
    `right_ck_taker` BOOLEAN NOT NULL,
    `penalty_taker` BOOLEAN NOT NULL,
    `number` INTEGER NOT NULL,

    UNIQUE INDEX `player_id`(`player_id`, `team_id`),
    UNIQUE INDEX `team_id`(`team_id`, `number`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `position` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `position_category_id` INTEGER NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `description` VARCHAR(255) NOT NULL,
    `short` VARCHAR(255) NOT NULL,

    INDEX `position_category_id`(`position_category_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `position_category` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `short` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `setting` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `description` VARCHAR(255) NOT NULL,
    `required` BOOLEAN NOT NULL,
    `min` INTEGER NULL,
    `max` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `setting_value` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `setting_id` INTEGER NOT NULL,
    `value` VARCHAR(255) NOT NULL,

    INDEX `setting_id`(`setting_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `special_ability` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `description` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `stadium` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `stadium_area_id` INTEGER NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `real_name` VARCHAR(255) NULL,
    `built` DATE NOT NULL,
    `capacity` INTEGER NOT NULL,

    INDEX `stadium_area_id`(`stadium_area_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `stadium_area` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `team` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `league_id` INTEGER NOT NULL,
    `stadium_id` INTEGER NOT NULL,
    `formation_id` INTEGER NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `real_name` VARCHAR(255) NULL,
    `short` VARCHAR(255) NOT NULL,

    INDEX `formation_id`(`formation_id`),
    INDEX `league_id`(`league_id`),
    INDEX `stadium_id`(`stadium_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `appearance_value` ADD CONSTRAINT `appearance_value_ibfk_1` FOREIGN KEY (`appearance_id`) REFERENCES `appearance`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `league` ADD CONSTRAINT `league_ibfk_1` FOREIGN KEY (`league_category_id`) REFERENCES `league_category`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `player` ADD CONSTRAINT `player_ibfk_1` FOREIGN KEY (`nationality_id`) REFERENCES `nationality`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `players_abilities` ADD CONSTRAINT `players_abilities_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `players_abilities` ADD CONSTRAINT `players_abilities_ibfk_2` FOREIGN KEY (`ability_id`) REFERENCES `ability`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `players_appearances` ADD CONSTRAINT `players_appearances_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `players_appearances` ADD CONSTRAINT `players_appearances_ibfk_2` FOREIGN KEY (`appearance_id`) REFERENCES `appearance`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `players_appearances` ADD CONSTRAINT `players_appearances_ibfk_3` FOREIGN KEY (`appearance_value_id`) REFERENCES `appearance_value`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `players_positions` ADD CONSTRAINT `players_positions_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `players_positions` ADD CONSTRAINT `players_positions_ibfk_2` FOREIGN KEY (`position_id`) REFERENCES `position`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `players_settings` ADD CONSTRAINT `players_settings_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `players_settings` ADD CONSTRAINT `players_settings_ibfk_2` FOREIGN KEY (`setting_id`) REFERENCES `setting`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `players_settings` ADD CONSTRAINT `players_settings_ibfk_3` FOREIGN KEY (`setting_value_id`) REFERENCES `setting_value`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `players_special_abilities` ADD CONSTRAINT `players_special_abilities_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `players_special_abilities` ADD CONSTRAINT `players_special_abilities_ibfk_2` FOREIGN KEY (`special_ability_id`) REFERENCES `special_ability`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `players_teams` ADD CONSTRAINT `players_teams_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `players_teams` ADD CONSTRAINT `players_teams_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `team`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `position` ADD CONSTRAINT `position_ibfk_1` FOREIGN KEY (`position_category_id`) REFERENCES `position_category`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `setting_value` ADD CONSTRAINT `setting_value_ibfk_1` FOREIGN KEY (`setting_id`) REFERENCES `setting`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `stadium` ADD CONSTRAINT `stadium_ibfk_1` FOREIGN KEY (`stadium_area_id`) REFERENCES `stadium_area`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `team` ADD CONSTRAINT `team_ibfk_1` FOREIGN KEY (`league_id`) REFERENCES `league`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `team` ADD CONSTRAINT `team_ibfk_2` FOREIGN KEY (`stadium_id`) REFERENCES `stadium`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `team` ADD CONSTRAINT `team_ibfk_3` FOREIGN KEY (`formation_id`) REFERENCES `formation`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

